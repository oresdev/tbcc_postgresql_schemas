DROP FUNCTION IF EXISTS v3.u_set_user_by_address(useraddress TEXT[], accounttype TEXT, smartcard BOOLEAN);
CREATE OR REPLACE FUNCTION v3.u_set_user_by_address (useraddress TEXT[], accounttype TEXT, smartcard BOOLEAN)
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  PARALLEL SAFE
AS
$function$

UPDATE
  v3.users u
SET
  useraddress = u_set_user_by_address.useraddress,
  accounttype = u_set_user_by_address.accounttype,
  smartcard = u_set_user_by_address.smartcard
WHERE
  u.useraddress && u_set_user_by_address.useraddress
RETURNING
  to_json(u.id);

$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_set_user_by_address(
--   useraddress := '{qwer,ty}',
--   accounttype := 'Pro',
--   smartcard := FALSE
-- );

/* Результат
"8550088d-86eb-47bf-9816-beed320a0a93"
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_set_user_by_address(
--          useraddress := '{qwert}',
--          accounttype := 'Pro',
--          smartcard := FALSE
--          );

/* Результат
NULL
*/