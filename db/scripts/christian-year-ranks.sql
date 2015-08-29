--
-- Year ranks, by receipts and total sold as listed in the registers,
-- for the following dates: '07 Nov', '09 Jan', '09 Apr', '11 Jun', '14 Dec'
--
-- (Look farther down for data. The query is included here so we can re-run it if necessary later.)

-- Date when report was run:
select now()::date;
set search_path = warehouse;

-- Query
create view foo as 
with stats as (
  select date, 
         sum(price * sold) as receipts, 
         sum(sold) as total_sold
  from sales 
  group by date
), playbill as (
  select date, 
         array_agg(distinct (substring(author from '([^(]*)') || '/ ' || substring(title from '([^(]*)'))) as plays
  from performances join plays using (play_id)
  group by date
), summary as (
  select to_char(date, 'DD Mon') as day,
         to_char(date, 'YYYY') as year,
         stats.*,
         playbill.*
  from stats join playbill using (date)
) select day as jour,
         year as annee,
         to_char(receipts, '999G999G999G990D00') as recettes, 
         rank() over (partition by day order by receipts desc) as recettes_ordre,
         to_char(total_sold, '999G999G999G990') as vendu, 
         rank() over (partition by day order by total_sold desc) as vendu_ordre,
         plays as carte
  from summary
  where day in ('07 Nov', '09 Jan', '09 Apr', '11 Jun', '14 Dec')
  order by to_date(day, 'DD Mon'), recettes_ordre;