DROP FUNCTION IF EXISTS v3.u_check_user_exist_by_uuid(id UUID);
CREATE OR REPLACE FUNCTION v3.u_check_user_exist_by_uuid(id UUID)
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
           v3.users u
         WHERE
           u.id = u_check_user_exist_by_uuid.id
         )

$function$
;

--Проверяем: Существующий пользователь
-- SELECT v3.u_check_user_exist_by_uuid('8550088d-86eb-47bf-9816-beed320a0a93');

/* Результат
TRUE
*/

--Проверяем: Несуществующий пользователь
-- SELECT v3.u_check_user_exist_by_uuid('8550088d-86eb-47bf-9816-beed320a0a94');

/* Результат
FALSE
*/