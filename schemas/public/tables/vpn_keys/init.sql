DROP INDEX IF EXISTS public.idx_vpn_keys_user_id;
CREATE INDEX idx_vpn_keys_user_id ON public.vpn_keys (user_id);
ANALYSE public.vpn_keys;