DROP FUNCTION IF EXISTS v3.vk_set_key_by_address(address TEXT, used BOOLEAN, txhash TEXT);
CREATE OR REPLACE FUNCTION v3.vk_set_key_by_address(address TEXT, used BOOLEAN, txhash TEXT)
  RETURNS JSON
  LANGUAGE 'plpgsql'
  VOLATILE
  PARALLEL SAFE
AS
$function$
DECLARE
  user_uuid UUID;
BEGIN
  
  SELECT INTO user_uuid
    id
  FROM
    v3.users u
  WHERE
    vk_set_key_by_address.address = ANY(u.useraddress)
  LIMIT 1;
  
  UPDATE
    v3.vpn_keys k
  SET
    user_id = user_uuid,
    used = vk_set_key_by_address.used,
    txhash = vk_set_key_by_address.txhash,
    "timestamp" = now()
  WHERE
      k.id = (
      SELECT
        vk.id
      FROM
        v3.vpn_keys vk
      WHERE
        vk.user_id IS NULL
      LIMIT  1
        FOR UPDATE SKIP LOCKED
    );
  
  RETURN v3.vk_get_keys_by_uuid(user_uuid);

END;
$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.vk_set_key_by_address(
--   address := 'qwer',
--   used := TRUE,
--   txhash := '123'
-- );

/* Результат
{"vpn_keys" : [{"id":8,"key":"YXMZ-CV66-VENK-GVVT","validity":12,"used":true,"user_id":"8550088d-86eb-47bf-9816-beed320a0a93","txhash":"123","with_pro":null,"timestamp":"2021-04-17T12:05:50.789974"}]}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.vk_set_key_by_address(
--          address := 'qwert',
--          used := TRUE,
--          txhash := '123'
--          );

/* Результат
NULL
*/