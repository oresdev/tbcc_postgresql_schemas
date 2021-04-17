DROP FUNCTION IF EXISTS v3.vk_get_keys_by_uuid;
CREATE OR REPLACE FUNCTION v3.vk_get_keys_by_uuid (user_id UUID)
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT
  json_build_object(
    'vpn_keys', json_agg(to_json(vk))
  )
FROM
  v3.users u
  LEFT JOIN v3.vpn_keys vk on u.id = vk.user_id
WHERE
    u.id = vk_get_keys_by_uuid.user_id
GROUP BY
  u;

$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.vk_get_keys_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c3');

/* Результат
SELECT v3.vk_get_keys_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c3');
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.vk_get_keys_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c4');

/* Результат
NULL
*/