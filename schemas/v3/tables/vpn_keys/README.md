# vpn_keys / Functions

В `init.sql` собираем индексы, если требуются, а заголовок функции `equal` имени файла.

Текущая версия [v3](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/):

### vk_get_keys_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/vpn_keys/vk_get_keys_by_uuid.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
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
  ]
}
```

### vk_get_keys_by_address()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/vpn_keys/vk_get_keys_by_address.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
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
  ]
}
```

### vk_set_key_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/vpn_keys/vk_set_key_by_uuid.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
  "vpn_keys": {
    "id": "int",
    "key": "string",
    "validity": "int",
    "used": "bool",
    "user_id": "uuid",
    "txhash": "string",
    "with_pro": "bool",
    "timestamp": "timestamp"
  }
}
```

### vk_set_key_by_address()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/vpn_keys/vk_set_key_by_address.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
  "vpn_keys": {
    "id": "int",
    "key": "string",
    "validity": "int",
    "used": "bool",
    "user_id": "uuid",
    "txhash": "string",
    "with_pro": "bool",
    "timestamp": "timestamp"
  }
}
```
