# Tables

Новая структура таблиц, которую приводим в порядок.

> #### Premature optimization is the root of all evil (or at least most of it) in programming.
>
> Donald Knuth

## Структура

Схема [v3](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/):

- [app_config](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_config/) - Собираем конфигурацию приложения
- [app_counter](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_counter/) - Считаем пользователей текущей версии обновления
- [app_update](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/app_update/) - Текущая версия приложения
- [users](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/) - Мигрированные пользователи
- [vpn_keys](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/vpn_keys/) - Ключи

Скорее всего таблиц еще прибавится.
