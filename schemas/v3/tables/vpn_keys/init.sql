DROP INDEX IF EXISTS v3.unq_vpn_keys_key;
CREATE UNIQUE INDEX unq_vpn_keys_key ON v3.vpn_keys (key);

DROP INDEX IF EXISTS v3.idx_vpn_keys_user_id;
CREATE INDEX idx_vpn_keys_user_id ON v3.vpn_keys (user_id);

ANALYSE v3.vpn_keys;