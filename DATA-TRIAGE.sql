-- DATA TRIAGE
--
--
-- This file identifies potentially corrupted rows in the database.  Run as follows to generate report:
--   psql cfrp_development -a -f DATA-TRIAGE.sql > report.txt
--
-- NB (1) When register "ids" are mentioned below they refer to the registers.id column, which uniquely
--        identifies a single register row in the database.
--
--    (2) Some corrupt rows will appear multiple places in this report.  Addressing one issue may also
--        resolve later ones.
--
--    (3) Some queries identify known-bad information.  Others only signal potential corruption.  Use
--        your discretion.
--
--    (3) The queries in this file were written with expediency in mind.  They are not intended to be
--        models of good relational form.

--
-- Date when report was run:
select now();

--
-- *IMPORTANT*
--
-- show register entries with crazy dates:  (6 rows on 2015-03-09)
-- ACTION: delete
--
select date, id from registers where verification_state_id in (1,6) and (date < '01-04-1680' or date > '01-01-1794');

--
-- *VERY IMPORTANT*
--
-- show dates with more than one register entry: (134 rows on 2015-03-10)
-- NOTE: all duplicate register ids are listed; known corrupt ones are marked as 'most suspect'
-- ACTION: delete whichever is the duplicate
--
create function dow_fr(s text) returns int as $$
  select case s
  when 'Dimanche' then 0
  when 'Lundi' then 1
  when 'Mardi' then 2
  when 'Mercredi' then 3
  when 'Jeudi' then 4
  when 'Vendredi' then 5
  when 'Samedi' then 6
  else -1
  end
 $$ language sql;
with bad_weekdays as (select date, array_agg(id order by id) as ids from registers where verification_state_id in (1,6) and dow_fr(weekday) <> extract(dow from date) group by date),
     ok_weekdays  as (select date, array_agg(id order by id) as ids from registers where verification_state_id in (1,6) and dow_fr(weekday) = extract(dow from date) group by date),
     duplicates   as (select date, count(*) from registers where verification_state_id in (1,6) group by date having count(*) > 1)
select d.date, count, bw.ids as most_suspect_ids, ow.ids as suspect_ids from duplicates d left outer join bad_weekdays bw using (date) left outer join ok_weekdays ow using (date);

--
-- show register entries lacking a season: (4 rows on 2015-03-10)
-- ACTION: as necessary
--
select date, id from registers where verification_state_id in (1,6) and (season is null or season = '');

--
-- show non-duplicate register entries with wrong weekday or date: (248 rows on 2015-03-11)
-- ACTION: check as necessary
--
select date, array_agg(id) as ids, weekday, to_char(date, 'Day') as calculated from registers where verification_state_id in (1,6) and dow_fr(weekday) <> extract(dow from date) group by date, weekday having count(*) = 1 order by date;

--
-- *IMPORTANT*
-- 
-- show register entries with more than one play for a single ordering slot: (32 rows on 2015-03-09)
-- [ orderings should be sequential, e.g. : 1,2,3... ]
-- ACTION: correct ordering, or delete duplicates
--
with duplicates as (
  select registers.id from registers join register_plays on (register_id = registers.id) where verification_state_id in (1,6) group by registers.id, ordering having count(*) > 1
), registers_with_ordering_list as (
  select registers.id, date, array_agg(ordering order by ordering) as ordering, array_agg(title::varchar(15) order by ordering) as titles from registers join register_plays on (register_id = registers.id) join plays on (play_id = plays.id) where verification_state_id in (1,6) group by registers.id
) select * from duplicates join registers_with_ordering_list using (id);

--
-- *IMPORTANT*
-- 
-- show performances missing preceding order entries:  (42 rows on 2015-03-09)
-- ACTION: correct ordering of plays performed on these dates
--
with missing_orderings as (
  select registers.id from register_plays join registers on (registers.id = register_id) join plays on (plays.id = play_id) where verification_state_id in (1,6) and ordering > 1 and not exists (select 1 from register_plays as foo where foo.register_id = registers.id and foo.ordering = register_plays.ordering - 1) order by date, ordering
), registers_with_ordering_list as (
  select registers.id, date, array_agg(ordering order by ordering) as ordering, array_agg(title::varchar(15) order by ordering) as titles from registers join register_plays on (register_id = registers.id) join plays on (play_id = plays.id) where verification_state_id in (1,6) group by registers.id
) select * from missing_orderings join registers_with_ordering_list using (id);

--
-- show image entries with seemingly bad filenames:  (20 rows on 2015-03-09)
-- ACTION: fix
--
select date, register_id, filepath, image_file_name from register_images join registers on (register_id = registers.id) where verification_state_id in (1,6) and not image_file_name ilike 'M119_02%' order by date;

--
-- *IMPORTANT*
-- show duplicate entries in the plays table: (76 rows on 2015-03-11)
-- ACTION: delete the duplicate entries.  nothing to be done if these are actually different plays.
--
select title, array_agg(author::varchar(20)) as authors, count(*) as duplicates from plays where expert_validated group by title having count(*) > 1 order by count(*) desc;

--
-- *IMPORTANT*
-- indicating anonymous authorship: several conventions in use, which should be standard?  (127 plays on 2015-03-09)
-- ACTION: choose preferred convention and change play authors as necessary
-- 
select author, (author is null) as "null?", coalesce(author = '', false) as "empty?", count(*) from plays where expert_validated and author is null or author = '' or author ilike '%anony%' group by author order by "null?", "empty?";

--
-- show plays that have no associated performances:  (63 rows on 2015-03-09)
-- [ not necessarily a problem, but some of these entries seem incomplete... ]
-- ACTION: delete any completely faulty entries.  others are fine.
--
select author, title from plays where expert_validated and not exists (select 1 from register_plays where play_id = plays.id) group by author, title order by author, title;

--
-- *IMPORTANT*
--
-- show potentially duplicate play entries by title (truncated titles):  (53 rows on 2015-03-09)
-- ACTION: merge entries as necessary, using alternative_title.  make sure the existing register pages reference the
-- right play entry!
--
select table1.title as title1, table2.title as title2, count(*) as matches from plays table1, plays table2 where table1.expert_validated and table2.expert_validated and position(table1.title in table2.title) > 0 and table1.title <> table2.title and length(table1.title) > 0 group by table1.title, table2.title order by table1.title;

--
-- *IMPORTANT*
--
-- show variant author name spellings: (26 variants on 2015-03-09; some spurious)
-- ACTION: choose a standard spelling for each author and change as necessary
--
create extension if not exists fuzzystrmatch;
with matrix as (
  select table1.author as author1, table2.author as author2,
         levenshtein(table1.author, table2.author) * 2.0 / (length(table1.author) + length(table2.author)) as metric
  from plays table1, plays table2 where table1.expert_validated and table2.expert_validated and table1.author < table2.author
) select author1, author2, round(metric, 2) as proportion_changed from matrix where metric < 0.25 group by author1, author2, metric order by metric;

--
-- *IMPORTANT*
--
-- show potentially duplicate author entries (truncated names): (49 rows on 2015-03-09)
-- ACTION: choose a standard spelling and change others as necessary
--
select table1.author, table2.author from plays table1, plays table2 where table1.expert_validated and table2.expert_validated and position(table1.author in table2.author) > 0 and table1.author <> table2.author and length(table1.author) > 0 group by table1.author, table2.author order by table1.author;

--
-- show performances with goofy total receipts and no payment error note (more than 5 livres different):  (23 rows on 2015-03-09)
-- ACTION: proof data entry if desired
--
select id, date, total_receipts_recorded_l, sum, payment_notes from
  (select total_receipts_recorded_l, sum(recorded_total_l) as sum, date, registers.id, payment_notes from registers join ticket_sales on (register_id = registers.id) group by registers.id, registers.date, total_receipts_recorded_l order by date) as foo
  where total_receipts_recorded_l - sum > 5 and not payment_notes ilike '%err%'
  order by date;

--
-- show potentially variant people name spellings: (14 rows on 2015-03-24)
-- ACTION: not sure, possibly delete duplicates
--
create extension if not exists fuzzystrmatch;
with matrix as (
  select table1.last_name as last_name1, table2.last_name as last_name2,
         levenshtein(table1.last_name, table2.last_name) * 2.0 / (length(table1.last_name) + length(table2.last_name)) as metric
  from people table1, people table2 where table1.last_name < table2.last_name and table1.last_name <> '' and table2.last_name <> ''
) select last_name1, last_name2, round(metric, 2) as proportion_changed from matrix where metric < 0.25 group by last_name1, last_name2, metric order by metric;

-- 
-- plays that should have expert_validated as 'false' instead of empty
select id, title::char(40), expert_validated from plays where expert_validated is null;

--
-- register pages that refer to a non-expert validated play
--
select title, array_agg(registers.id) as register_ids from registers join register_plays on (registers.id = register_id) join plays on (plays.id = play_id) where verification_state_id in (1,6) and (not expert_validated or expert_validated is null) group by title order by title;

-- 
-- summary of genres
-- 
select genre, count(*) from plays where expert_validated group by genre order by genre;


--
-- show titles of plays with unusual numbers of acts
--
select acts, array_agg(title) from plays where expert_validated and acts is null or acts < 1 or acts > 5 group by acts order by acts;


--
-- summary of prose/verse field
-- 
select prose_vers, count(*) from plays where expert_validated group by prose_vers;


--
-- summary of musique_danse_machine
--
select musique_danse_machine, count(*) from plays where expert_validated group by musique_danse_machine;

--
-- summary of plays with no creation date
--
select author::char(30), title::char(30) from plays where expert_validated and date_de_creation is null order by author, title;

--
-- signatory: some spelling variations here
--
select signatory, count(*), case when count(*) < 15 then array_agg(id) end as ids from registers where verification_state_id in (1,6) group by signatory order by signatory;

-- 
-- ouverture, cloture
-- ACTION: correct?
-- 
with ouvertures as (
  select date as marked_ouverture, season from registers where verification_state_id in (1,6) and ouverture
), clotures as (
  select date as marked_cloture, season from registers where verification_state_id in (1,6) and cloture
), minmax as (
  select season, min(date) as first_register_date, max(date) as last_register_date from registers where verification_state_id in (1,6) group by season
)
select season, marked_ouverture, first_register_date, coalesce(marked_ouverture = first_register_date, false) as "ouverture_correct?", marked_cloture, last_register_date, coalesce(marked_cloture = last_register_date, false) as "cloture_correct?" from minmax left outer join clotures using (season) left outer join ouvertures using (season) 
order by season;

-- 
-- free_access
-- ACTION: decide if empty means "false"
--
select free_access, count(*) from register_plays group by free_access;


--
-- firstrun or reprise field is empty
-- ACTION: decide if empty means "false"
-- 
select reprise, count(*) from register_plays group by reprise;
select firstrun, count(*) from register_plays group by firstrun;

--
-- firstrun or reprise performance number given, but not flagged as a firstrun or reprise
--

select date, register_id, firstrun, firstrun_perfnum, reprise, reprise_perfnum from registers join register_plays on (registers.id = register_id) 
where verification_state_id in (1,6) and ((firstrun_perfnum > 0 and not firstrun) or (reprise_perfnum > 0 and not reprise)) order by date;


--
-- actorrole
-- ACTION: messy field - probably nothing to be done here
-- 

select count(*), actorrole::char(80) from register_plays group by actorrole order by count(*) desc, actorrole;

--
-- debut.  does this field refer to actorrole
-- ACTION: decide if empty means "false"
--
select debut, count(*) from register_plays group by debut;

--
-- exceptional place.
-- ACTION: regularize.  only one option here, "palais royal"?
select ex_place, count(*) from register_plays group by ex_place order by ex_place;


--
-- exceptional attendance.
--
-- the first table shows the field as entered.  the second attempts to split it on commas.
--
-- ACTION: decide whether to regularize the field and put it in a separate table, as done with people.
--

select ex_attendance::char(50), count(*), case when count(*) < 15 then array_agg(register_id) end as ids from register_plays group by ex_attendance order by ex_attendance;

with split_ex_attendance as (
  select register_id, regexp_split_to_table(ex_attendance, E', ') as ex_attendance from register_plays
) select ex_attendance, count(*), case when count(*) < 15 then array_agg(register_id) end as ids from split_ex_attendance group by ex_attendance order by ex_attendance;


--
-- ex_representation
--
select ex_representation, count(*) from register_plays group by ex_representation order by ex_representation;


--
-- representation, firstrun_perfnum, reprise_perfnum
-- not consistently filled, and often off by 2-4 performances
-- ACTION: decide whether to populate automatically
--

-- with numbered as (
--   select id, date, season, representation, rank() over (partition by season order by date) as representation_calc from registers
-- ) select season, title::char(30), date, representation, representation_calc from numbered join register_plays on (register_id = numbered.id) join plays on (play_id = plays.id)
-- where representation is null or representation <> representation_calc
-- order by season, date;