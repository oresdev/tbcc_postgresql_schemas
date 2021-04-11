# clients / Functions

В `init.sql` собираем индексы, если требуются, а заголовок функции `equal` имени файла. Вызов функции происходит при инициализации приложения.

### c_migrate()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/public/tables/clients/c_migrate.sql) этой функции.

Ожидаем:

```json
address TEXT[]
```

Возвращаем:

```json
{
  "id": "uuid",
  "useraddress": ["string", "..."],
  "accounttype": "string",
  "smartcard": "bool",
  "vpn_keys": [
    {
      "id": "int",
      "key": "string",
      "validity": "int",
      "used": "bool",
      "user_id": "uuid",
      "txhash": "string",
      "with_pro": "bool",
      "timestamp": "timestamp"
    },
    "..."
  ],
  "app_config": {
    "config_group": "string",
    "value": {
      "key": "string"
    }
  }
}
```
