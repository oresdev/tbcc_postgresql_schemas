DROP INDEX IF EXISTS v3.unq_vpn_keys_key;
CREATE UNIQUE INDEX unq_vpn_keys_key ON v3.vpn_keys (key);
ANALYSE v3.vpn_keys;