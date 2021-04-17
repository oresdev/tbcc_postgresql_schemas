DROP FUNCTION IF EXISTS v3.au_set_update(au JSON);
CREATE OR REPLACE FUNCTION v3.au_set_update(au JSON)
  RETURNS JSON
  LANGUAGE SQL
  VOLATILE
  STRICT
AS
$function$

UPDATE v3.app_update
SET
  "version" = (au ->> 'version')::INTEGER,
  url = (au ->> 'url')::TEXT,
  "force" = (au ->> 'force')::BOOLEAN,
  checksum = (au ->> 'checksum')::TEXT,
  changelog = (au ->> 'changelog')::TEXT
RETURNING
  row_to_json(app_update);

$function$
;


--Проверяем
-- SELECT v3.au_set_update('{"version":1,"url":"http://test.me", "force":false, "checksum":"123abc", "changelog":"breaking change"}');

/* Результат
{"version":1,"url":"http://test.me","force":false,"checksum":"123abc","changelog":"breaking change"}
*/