DROP FUNCTION IF EXISTS v3.ac_increase_value();
CREATE OR REPLACE FUNCTION v3.ac_increase_value()
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  STRICT
AS
$function$

UPDATE v3.app_counter
SET
  "value" = "value" + 1
RETURNING
  row_to_json(app_counter);

$function$
;


--Проверяем
-- SELECT v3.ac_increase_value();

/* Результат
{"version":3,"value":2}
*/