# app_update / Functions

В `init.sql` собираем индексы, если требуются, а заголовок функции `equal` имени файла.

Текущая версия [v3](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/):

### au_get_update()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_update/au_get_update.sql) этой функции.

Возвращаем:

```json
{
  "version": "int",
  "url": "string",
  "force": "bool",
  "checksum": "string",
  "changelog": "string"
}
```

### au_set_update()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_update/au_set_update.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
200
```
