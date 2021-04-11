DROP FUNCTION IF EXISTS v3.ac_get_config;
CREATE OR REPLACE FUNCTION v3.ac_get_config()
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
    v3.app_config ac
  LIMIT 1;
  
$function$
;

--Проверяем
-- SELECT v3.get_app_config();

/* Результат
{"config_group":"app","value":{"key": "value"}}
*/