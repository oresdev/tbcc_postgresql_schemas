DROP INDEX IF EXISTS public.idx_clients_address;
CREATE INDEX idx_clients_address ON public.clients (address);
ANALYSE public.clients;