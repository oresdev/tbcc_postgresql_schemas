DROP FUNCTION IF EXISTS v3.u_get_user_by_uuid(user_id UUID);
CREATE OR REPLACE FUNCTION v3.u_get_user_by_uuid(user_id UUID)
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
    u.id = u_get_user_by_uuid.user_id;
  
$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_get_user_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c3');

/* Результат
{
  "id": "89b80bce-a510-414b-8b0b-8c3bfdda23c3",
  "useraddress": [
    "bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm",
    "bnb1qnw2krjmg9tek4z8l75hq3hj94n0y6u0wv6rq2",
    "bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l",
    "bnb17tlvvrrfrngs5tq3aad84tejalml3qx8yxkp7l"
  ],
  "accounttype": "Premium",
  "smartcard": true
}
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_get_user_by_uuid('89b80bce-a510-414b-8b0b-8c3bfdda23c4');

/* Результат
NULL
*/