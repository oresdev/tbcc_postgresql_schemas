DROP FUNCTION IF EXISTS v3.u_set_user_by_uuid;
CREATE OR REPLACE FUNCTION v3.u_set_user_by_uuid (user_id UUID, useraddress TEXT[], accounttype TEXT, smartcard BOOLEAN)
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  PARALLEL SAFE
AS
$function$
  
  UPDATE
    v3.users u
  SET
    useraddress = u_set_user_by_uuid.useraddress,
    accounttype = u_set_user_by_uuid.accounttype,
    smartcard = u_set_user_by_uuid.smartcard
  WHERE
    u.id = u_set_user_by_uuid.user_id
  RETURNING
    row_to_json(u);
  
$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_set_user_by_uuid(
--   user_id := '89b80bce-a510-414b-8b0b-8c3bfdda23c3',
--   useraddress := '{qwer,ty}',
--   accounttype := 'Pro',
--   smartcard := FALSE
-- );

/* Результат
{"id":"89b80bce-a510-414b-8b0b-8c3bfdda23c3","useraddress":["qwer","ty"],"accounttype":"Pro","smartcard":false}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_set_user_by_uuid(
--          user_id := '89b80bce-a510-414b-8b0b-8c3bfdda23c4',
--          useraddress := '{qwer,ty}',
--          accounttype := 'Pro',
--          smartcard := FALSE
--          );

/* Результат
NULL
*/