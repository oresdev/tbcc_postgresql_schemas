DROP FUNCTION IF EXISTS v3.au_get_update();
CREATE OR REPLACE FUNCTION v3.au_get_update()
  RETURNS JSON
  LANGUAGE SQL
  STABLE
  STRICT
  PARALLEL SAFE
AS
$function$

SELECT
  row_to_json(au)
FROM
  v3.app_update au
LIMIT 1;

$function$
;

--Проверяем
-- SELECT v3.au_get_update();

/* Результат
{"version":1,"url":"http://test.me","force":false,"checksum":"123abc","changelog":"breaking change"}
*/