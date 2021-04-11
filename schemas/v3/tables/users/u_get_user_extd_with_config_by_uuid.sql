DROP FUNCTION IF EXISTS v3.u_get_user_extd_with_config_by_uuid;
CREATE OR REPLACE FUNCTION v3.u_get_user_extd_with_config_by_uuid (user_id UUID)
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
        'vpn_keys', jsonb_agg(to_jsonb(vk)),
        'app_config', v3.get_app_config()
      )
    )::JSON
  FROM
    v3.users u
    LEFT JOIN v3.vpn_keys vk on u.id = vk.user_id
  WHERE
    u.id = u_get_user_extd_with_config_by_uuid.user_id
  GROUP BY
    u;
  
$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_get_user_extd_with_config_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c3');

/* Результат
{
  "id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
  "vpn_keys": [
    {
      "id": 129,
      "key": "5SXX-VARS-QAGK-TGMQ",
      "used": true,
      "txhash": "E7C1EA11192874C9A5F1B6CEA166A80F1659AF35B9AAE30890579CECE9FFD5E9",
      "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
      "validity": 12,
      "with_pro": null,
      "timestamp": null
    },
    {
      "id": 14450,
      "key": "A9DJ-CN26-HT9Y-URSA",
      "used": true,
      "txhash": "913576104B9243F1A090F5F6315E47814A71C1D034AE5BD4910BE5E460A45CE6",
      "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
      "validity": 3,
      "with_pro": true,
      "timestamp": "2020-12-07T14:44:07.007905"
    }
  ],
  "smartcard": true,
  "app_config": {
    "value": {
      "key": "value"
    },
    "config_group": "app"
  },
  "accounttype": "Premium",
  "useraddress": [
    "bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm",
    "bnb1qnw2krjmg9tek4z8l75hq3hj94n0y6u0wv6rq2",
    "bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l",
    "bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l"
  ]
}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_get_user_extd_with_config_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c4');

/* Результат
NULL
*/