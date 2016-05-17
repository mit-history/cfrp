-- read-only guest user account for 2016 MIT hackathon

create user guest with password 'cfrp-hackathon-2016';
grant usage on schema warehouse to guest;
alter user guest set search_path to warehouse;
revoke usage on schema public from guest;
grant select on all tables in schema warehouse to guest;
