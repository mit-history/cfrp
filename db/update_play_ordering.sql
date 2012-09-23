update register_plays set ordering = 3 where register_id in (select register_id from register_plays where ordering = 0) and ordering = 2;
update register_plays set ordering = 2 where register_id in (select register_id from register_plays where ordering = 0) and ordering = 1;
update register_plays set ordering = 1 where register_id in (select register_id from register_plays where ordering = 0) and ordering = 0;
