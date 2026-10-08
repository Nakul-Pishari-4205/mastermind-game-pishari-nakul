create table if not exists public.game_rounds (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  difficulty text not null check (difficulty in ('easy', 'medium', 'hard', 'extreme')),
  mode text not null check (mode in ('solo', 'pass', 'ai')),
  won boolean not null,
  guesses_used integer not null check (guesses_used between 1 and 10),
  created_at timestamptz not null default now()
);

alter table public.game_rounds enable row level security;

revoke all on table public.game_rounds from anon;
grant select, insert on table public.game_rounds to authenticated;

drop policy if exists "Players can read their own rounds" on public.game_rounds;
create policy "Players can read their own rounds"
  on public.game_rounds for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Players can save their own rounds" on public.game_rounds;
create policy "Players can save their own rounds"
  on public.game_rounds for insert
  to authenticated
  with check ((select auth.uid()) = user_id);
