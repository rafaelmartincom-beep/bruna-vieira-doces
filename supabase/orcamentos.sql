-- Tabela de orçamentos do app Bruna Vieira Doces Finos.
-- Como usar: no Supabase, abra SQL Editor > New query, cole este arquivo inteiro e clique em Run.
-- Pode rodar mais de uma vez sem problema.

create table if not exists public.orcamentos (
  owner uuid not null default auth.uid() references auth.users (id) on delete cascade,
  id text not null,
  dados jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (owner, id)
);

alter table public.orcamentos enable row level security;

drop policy if exists "dono_orcamentos" on public.orcamentos;
create policy "dono_orcamentos" on public.orcamentos
  for all to authenticated
  using (owner = (select auth.uid()))
  with check (owner = (select auth.uid()));

grant select, insert, update, delete on public.orcamentos to authenticated;
revoke all on public.orcamentos from anon;
