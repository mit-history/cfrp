set search_path to warehouse, "$user", public;
update seating_category_profile set category = 'Troisièmes loges et Petites loges' where category = 'Troisièmes loges & Petites loges';
update seating_category_profile set category = 'Balcons' where category = 'Balconies';
update seating_category_profile set category = 'Premières loges et places sur le théâtre' where category = 'Premières loges and stage seating';
update seating_category_profile set category = 'Autres places non spécifiées' where category = 'All others';
update seating_category_profile set category = ' et ' where category = ' & ';
update seating_category_profile set category = 'Premières loges et places sur le théâtre' where category = 'Premières loges and stage seating';
update seating_category_profile set category = 'Balcons' where category = 'Balconies';
update seating_category_profile set category = 'Autres places non spécifiées' where category = 'All others';
-- update seating_category_dim set category = 'Troisièmes loges et Petites loges' where category = 'Troisièmes loges & Petites loges';
-- update seating_category_dim set category = 'Troisièmes loges et Petites loges' where category = 'Troisièmes loges & Petites loges';
