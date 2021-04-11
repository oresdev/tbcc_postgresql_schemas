# app_config / Functions

В `init.sql` собираем индексы, если требуются, а заголовок функции `equal` имени файла.

Текущая версия [v3](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/):

### ac_get_config()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_config/ac_get_config.sql) этой функции.

Возвращаем:

```json
{
  "config_group": "string",
  "value": {
    "key": "string"
  }
}
```

### ac_set_config()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_config/ac_set_config.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
200
```
