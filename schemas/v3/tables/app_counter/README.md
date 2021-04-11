# app_counter / Functions

В `init.sql` собираем индексы, если требуются, а заголовок функции `equal` имени файла.

Текущая версия [v3](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/):

### ac_get_counter()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_counter/ac_get_counter.sql) этой функции.

Возвращаем:

```json
{
  "version": "int",
  "value": "int"
}
```

### ac_increase_counter()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_counter/ac_increase_counter.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
  "version": "int",
  "value": "int"
}
```
