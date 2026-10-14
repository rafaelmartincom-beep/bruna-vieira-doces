-- Banco do app Bruna Vieira Doces Finos.
-- Como usar: no Supabase, abra SQL Editor > New query, cole este arquivo inteiro e clique em Run.
-- Pode rodar mais de uma vez sem problema.
-- Cada conta só enxerga e altera os próprios dados (Row Level Security).

create table if not exists public.ingredientes (
  owner uuid not null default auth.uid() references auth.users (id) on delete cascade,
  id text not null,
  dados jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (owner, id)
);

create table if not exists public.receitas (
  owner uuid not null default auth.uid() references auth.users (id) on delete cascade,
  id text not null,
  dados jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (owner, id)
);

create table if not exists public.config (
  owner uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  precos jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.ingredientes enable row level security;
alter table public.receitas enable row level security;
alter table public.config enable row level security;

drop policy if exists "dono_ingredientes" on public.ingredientes;
create policy "dono_ingredientes" on public.ingredientes
  for all to authenticated
  using (owner = (select auth.uid()))
  with check (owner = (select auth.uid()));

drop policy if exists "dono_receitas" on public.receitas;
create policy "dono_receitas" on public.receitas
  for all to authenticated
  using (owner = (select auth.uid()))
  with check (owner = (select auth.uid()));

drop policy if exists "dono_config" on public.config;
create policy "dono_config" on public.config
  for all to authenticated
  using (owner = (select auth.uid()))
  with check (owner = (select auth.uid()));

grant select, insert, update, delete on public.ingredientes, public.receitas, public.config to authenticated;
revoke all on public.ingredientes, public.receitas, public.config from anon;
