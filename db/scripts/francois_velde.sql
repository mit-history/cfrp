-- for François Velde, August 2016

set search_path = warehouse;

copy (
select date,
       sum(sold * price) as receipts,
       min(play_1_id) as play_1_id,
       min(play_2_id) as play_2_id,
       min(play_3_id) as play_3_id,
       min(play_4_id) as play_4_id
from sales_facts
group by date
order by date
) to '/tmp/receipts.csv' with csv header;

copy (
select *
from play_dim
where exists (select 1 from sales_facts
              where play_dim.id in (play_1_id, play_2_id, play_3_id, play_4_id))
order by id
) to '/tmp/plays.csv' with csv header;

-- September 2016

set search_path = warehouse, public;

copy(
select date,
       price,
       sold,
       seating_categories.name
from sales_facts
join ticket_sales on (ticket_sales_id = ticket_sales.id)
join seating_categories on (seating_category_id = seating_categories.id)
where date < '1680-06-01'
order by date, price
) to '/tmp/sales.csv' with csv header;
