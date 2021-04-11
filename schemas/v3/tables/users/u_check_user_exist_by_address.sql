DROP FUNCTION IF EXISTS v3.u_check_user_exist_by_address(addresses TEXT[]);
CREATE OR REPLACE FUNCTION v3.u_check_user_exist_by_address(addresses TEXT[])
  RETURNS BOOLEAN
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT EXISTS
  (
    SELECT
    FROM
      v3.users
      WHERE useraddress && u_check_user_exist_by_address.addresses
  )
  
$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_check_user_exist_by_address(ARRAY['bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm', 'blah']);

/* Результат
TRUE
*/

--Проверяем: Существуют не все адреса
-- SELECT v3.u_check_user_exist_by_address(ARRAY['bnb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm', 'lah']);

/* Результат
TRUE
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_check_user_exist_by_address(ARRAY['nb1s76hyee7xvxksxlkc4whsmc3gxuqhrqvd3y0zm', 'lah']);

/* Результат
FALSE
*/