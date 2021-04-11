DROP INDEX IF EXISTS v3.unq_users_useraddress;
CREATE UNIQUE INDEX unq_users_useraddress ON v3.users (useraddress);
ANALYSE v3.users;

-- DROP FUNCTION IF EXISTS v3.add_user;
-- CREATE OR REPLACE FUNCTION v3.add_user (useraddress TEXT[], accounttype TEXT, smartcard BOOLEAN)
--   RETURNS JSON
--   LANGUAGE SQL
--   VOLATILE
--   PARALLEL SAFE
-- AS
-- $function$
  
--   INSERT INTO v3.users(useraddress, accounttype, smartcard)
--   VALUES (
--     add_user.useraddress,
--     add_user.accounttype,
--     add_user.smartcard
--   )
--   RETURNING
--     row_to_json(users);
  
-- $function$
-- ;

--Проверяем: Новый пользователь
-- SELECT v3.add_user(
--   useraddress := '{asdf,ghj}',
--   accounttype := 'Pro',
--   smartcard := FALSE
-- );

/* Результат
{"id":"e18d810e-7d1e-4a13-8d6d-260a93753699","useraddress":["asdf","ghj"],"accounttype":"Pro","smartcard":false}
*/