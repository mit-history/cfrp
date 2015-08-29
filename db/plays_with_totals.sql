create view performances_with_totals as select r.total_receipts_recorded_l as total, r.date, p.id, p.title from registers r left join register_plays rp on r.id = rp.register_id left join plays p on rp.play_id = p.id;
create materialized view plays_with_totals as select distinct p.id, p.title, (SELECT SUM(total) FROM performances_with_totals WHERE id = p.id) as total from plays p left join performances_with_totals t on p.id = t.id where t.total is not null and p.title is not null order by p.id;