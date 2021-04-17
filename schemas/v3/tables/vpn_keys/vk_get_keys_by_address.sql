DROP FUNCTION IF EXISTS v3.vk_get_keys_by_address;
CREATE OR REPLACE FUNCTION v3.vk_get_keys_by_address (address TEXT)
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
    vk_get_keys_by_address.address = ANY(u.useraddress)
GROUP BY
  u;

$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.vk_get_keys_by_address('bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm');

/* Результат
{"vpn_keys" : [{"id":9992,"key":"YA5J-5CE4-NN3E-5PF5","validity":3,"used":true,"user_id":"61ea84b5-2341-4a2d-820b-bea083c49d01","txhash":"3D967200B94A8D8F54F28429D63C7562FA11588D89DF42757BBF63675FA17BAD","with_pro":null,"timestamp":"2020-12-07T11:46:20.866339"}]}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.vk_get_keys_by_address('lorem1');

/* Результат
NULL
*/