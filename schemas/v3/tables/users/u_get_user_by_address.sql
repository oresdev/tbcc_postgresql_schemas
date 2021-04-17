DROP FUNCTION IF EXISTS v3.u_get_user_by_address(address TEXT);
CREATE OR REPLACE FUNCTION v3.u_get_user_by_address(address TEXT)
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT
  row_to_json(u)
FROM
  v3.users u
WHERE
  u_get_user_by_address.address = ANY(u.useraddress)
LIMIT 1
;

$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_get_user_by_address('lorem');

/* Результат
{"id":"8550088d-86eb-47bf-9816-beed320a0a93","useraddress":["lorem"],"accounttype":"Free","smartcard":false}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_get_user_by_address('lorem1');

/* Результат
NULL
*/