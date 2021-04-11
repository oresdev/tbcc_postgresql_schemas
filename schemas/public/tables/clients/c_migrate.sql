DROP FUNCTION IF EXISTS v3.c_migrate;
CREATE OR REPLACE FUNCTION v3.c_migrate (addresses TEXT[])
  RETURNS JSON
LANGUAGE 'plpgsql'
VOLATILE
STRICT
PARALLEL SAFE
AS
$function$
DECLARE
  usr_id UUID;
  usr_useraddress TEXT[];
  usr_accounttype TEXT;
  usr_smartcard BOOLEAN;
  vkeys public.vpn_keys[];
  vk JSON;
  res JSON;
BEGIN

WITH i AS (
    SELECT unnest(c_migrate.addresses) addr
)

SELECT INTO usr_useraddress, usr_accounttype, usr_smartcard, vkeys
    coalesce(
      array_agg(cl.address) FILTER (WHERE cl.id IS NOT NULL),
      c_migrate.addresses
    ),

    CASE min(cl.paid_fee)
      WHEN 1.5 THEN 'Premium'
      WHEN 2 THEN 'Pro'
      ELSE 'Free'
    END,

    CASE
      WHEN min(cl.paid_smart_card) IS NULL THEN FALSE
      ELSE TRUE
    END,

    array_agg(k) FILTER (WHERE k.id IS NOT NULL)
  FROM
    i
    LEFT JOIN public.clients cl ON i.addr = cl.address
    LEFT JOIN public.vpn_keys k ON k.user_id = cl.id
  ;

INSERT INTO v3.users (useraddress, accounttype, smartcard)
VALUES (
  usr_useraddress,
  usr_accounttype,
  usr_smartcard
  )
  ON CONFLICT (useraddress) DO UPDATE
  SET
    useraddress = EXCLUDED.useraddress,
    accounttype = EXCLUDED.accounttype,
    smartcard = EXCLUDED.smartcard
  RETURNING
    id INTO usr_id;

WITH a AS (
INSERT INTO v3.vpn_keys (key, validity, used, user_id, txhash, with_pro, "timestamp")
SELECT
  k.key,
  k.validity,
  k.used,
  usr_id,
  k.txhash,
  k.with_pro,
  k."timestamp"
FROM
  unnest(vkeys) k
  ON CONFLICT (key) DO UPDATE
    SET
      validity = EXCLUDED.validity,
      used = EXCLUDED.used,
      user_id = EXCLUDED.user_id,
      txhash = EXCLUDED.txhash,
      with_pro = EXCLUDED.with_pro,
      timestamp = EXCLUDED.timestamp
    RETURNING
      row_to_json(vpn_keys) k
)

SELECT INTO vk json_agg(k) FROM a;

res := json_build_object(
  'user_id', usr_id,
  'useraddress', usr_useraddress,
  'accounttype', usr_accounttype,
  'smartcard', usr_smartcard,
  'vpn_keys', vk,
  'app_config', v3.ac_get_config()
  );

RETURN res;
END;
$function$
;

--Проверяем. Значения address подставляем через запятую.
-- SELECT v3.c_migrate ('{bnb17pq9tmd0ueect3rjhh0hgsspad4v2kw3d0qkjq,bla,blah,blahh}');

/* Результат
 {
  "user_id": "aa65832a-2838-4d5d-9005-6f4663507b0d",
  "useraddress": [
    "bnb17pq9tmd0ueect3rjhh0hgsspad4v2kw3d0qkjq"
  ],
  "accounttype": "Premium",
  "smartcard": true,
  "vpn_keys": null,
  "app_config": {
    "config_group": "app",
    "value": {
      "key": "value"
    }
  }
}
 */
 
--Проверяем создание нового пользователя.
-- SELECT v3.c_migrate ('{bla,blah,blahh}');

/* Результат
 {
  "user_id": "a17a3166-1c28-45ed-af99-95558eeaf8c9",
  "useraddress": [
    "bla",
    "blah",
    "blahh"
  ],
  "accounttype": "Free",
  "smartcard": false,
  "vpn_keys": null,
  "app_config": {
    "config_group": "app",
    "value": {
      "key": "value"
    }
  }
}
 */
 
--Проверяем на одной реальной записи
-- SELECT v3.c_migrate(ARRAY[
--   'bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm'
-- ]);

/* Результат
 {
  "user_id": "61ea84b5-2341-4a2d-820b-bea083c49d01",
  "useraddress": [
    "bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm"
  ],
  "accounttype": "Pro",
  "smartcard": true,
  "vpn_keys": [
    {
      "id": 9992,
      "key": "YA5J-5CE4-NN3E-5PF5",
      "validity": 3,
      "used": true,
      "user_id": "61ea84b5-2341-4a2d-820b-bea083c49d01",
      "txhash": "3D967200B94A8D8F54F28429D63C7562FA11588D89DF42757BBF63675FA17BAD",
      "with_pro": null,
      "timestamp": "2020-12-07T11:46:20.866339"
    }
  ],
  "app_config": {
    "config_group": "app",
    "value": {
      "key": "value"
    }
  }
}
 */
 
--Проверяем несколько реальных записей
-- SELECT v3.c_migrate(ARRAY[
--   'bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm',
--   'bnb1qnw2krjmg9tek4z8l75hq3hj94n0y6u0wv6rq2',
--   'bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l'
-- ]);

/* Результат
 {
  "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
  "useraddress": [
    "bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm",
    "bnb1qnw2krjmg9tek4z8l75hq3hj94n0y6u0wv6rq2",
    "bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l",
    "bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l"
  ],
  "accounttype": "Premium",
  "smartcard": true,
  "vpn_keys": [
    {
      "id": 9992,
      "key": "YA5J-5CE4-NN3E-5PF5",
      "validity": 3,
      "used": true,
      "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
      "txhash": "3D967200B94A8D8F54F28429D63C7562FA11588D89DF42757BBF63675FA17BAD",
      "with_pro": null,
      "timestamp": "2020-12-07T11:46:20.866339"
    },
    {
      "id": 129,
      "key": "5SXX-VARS-QAGK-TGMQ",
      "validity": 12,
      "used": true,
      "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
      "txhash": "E7C1EA11192874C9A5F1B6CEA166A80F1659AF35B9AAE30890579CECE9FFD5E9",
      "with_pro": null,
      "timestamp": null
    },
    {
      "id": 14450,
      "key": "A9DJ-CN26-HT9Y-URSA",
      "validity": 3,
      "used": true,
      "user_id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
      "txhash": "913576104B9243F1A090F5F6315E47814A71C1D034AE5BD4910BE5E460A45CE6",
      "with_pro": true,
      "timestamp": "2020-12-07T14:44:07.007905"
    }
  ],
  "app_config": {
    "config_group": "app",
    "value": {
      "key": "value"
    }
  }
}
 */