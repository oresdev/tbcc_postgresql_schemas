DROP FUNCTION IF EXISTS v3.ac_get_counter();
CREATE OR REPLACE FUNCTION v3.ac_get_counter()
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT
  row_to_json(ac)
FROM
  v3.app_counter ac
LIMIT 1;

$function$
;

--Проверяем
-- SELECT v3.ac_get_counter();

/* Результат
{"version":3,"value":0}
*/