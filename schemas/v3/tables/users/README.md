# users / Functions

В `init.sql` собираем индексы, если требуются, а заголовок функции `equal` имени файла.

Текущая версия [v3](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/):

### u_get_user_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_get_user_by_uuid.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
  "id": "uuid",
  "useraddress": ["string", "..."],
  "accounttype": "string",
  "smartcard": "bool"
}
```

### u_get_user_extd_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_get_user_extd_by_uuid.sql) этой функции.

Ожидаем:

```json

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
  ]
}
```

### u_get_user_extd_with_config_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_get_user_extd_with_config_by_uuid.sql) этой функции.

Ожидаем:

```json

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

### u_check_user_exist_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_check_user_exist_by_uuid.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
bool
```

### u_get_user_by_address()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_get_user_by_address.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
{
  "id": "uuid",
  "useraddress": ["string", "..."],
  "accounttype": "string",
  "smartcard": "bool"
}
```

### u_get_user_extd_by_address()

Ожидаем:

```json

```

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_get_user_extd_by_address.sql) этой функции.

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
  ]
}
```

### u_get_user_extd_with_config_by_address()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_get_user_extd_with_config_by_address.sql) этой функции.

Ожидаем:

```json

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

### u_check_user_exist_by_address()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_check_user_exist_by_address.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
bool
```

### u_set_user_by_uuid()

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_set_user_by_uuid.sql) этой функции.

Ожидаем:

```json

```

Возвращаем:

```json
uuid
```

### u_set_user_by_address()

Ожидаем:

```json

```

[Source code](https://github.com/oresdev/tbcc_postgresql_schemas/tree/master/schemas/v3/tables/users/u_set_user_by_address.sql) этой функции.

Возвращаем:

```json
uuid
```
