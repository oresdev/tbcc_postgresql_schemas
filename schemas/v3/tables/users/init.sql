DROP INDEX IF EXISTS v3.unq_users_useraddress;
CREATE UNIQUE INDEX unq_users_useraddress ON v3.users (useraddress);
ANALYSE v3.users;