DROP FUNCTION IF EXISTS v3.ac_set_config(ac JSON);
CREATE OR REPLACE FUNCTION v3.ac_set_config(ac JSON)
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  STRICT
AS
$function$

UPDATE v3.app_config
  SET
    config_group = ac ->> 'config_group',
    value = ac -> 'value'
  RETURNING
    ac;

$function$
;


--Проверяем
-- SELECT v3.ac_set_config('{"config_group":"app","value":{"key": "value"}}');

/* Результат
{"config_group":"app","value":{"key": "value"}}
*/