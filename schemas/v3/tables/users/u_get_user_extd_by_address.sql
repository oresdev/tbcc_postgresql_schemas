DROP FUNCTION IF EXISTS v3.u_get_user_extd_by_address;
CREATE OR REPLACE FUNCTION v3.u_get_user_extd_by_address (address TEXT)
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT
  (
    to_jsonb(u) ||
    jsonb_build_object(
      'vpn_keys', jsonb_agg(to_jsonb(vk))
    )
  )::JSON
FROM
  v3.users u
  LEFT JOIN v3.vpn_keys vk on u.id = vk.user_id
WHERE
    u_get_user_extd_by_address.address = ANY(u.useraddress)
GROUP BY
  u;

$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_get_user_extd_by_address('lorem');

/* Результат
{"id": "8550088d-86eb-47bf-9816-beed320a0a93", "vpn_keys": [null], "smartcard": false, "accounttype": "Free", "useraddress": ["lorem"]}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_get_user_extd_by_address('lorem1');

/* Результат
NULL
*/