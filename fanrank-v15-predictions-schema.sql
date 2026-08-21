-- FanRank V15 prediction tables
-- Run this once in Supabase SQL Editor if not already run.

create table if not exists public.fixtures (
  id uuid primary key default gen_random_uuid(),
  gameweek integer not null,
  home_team text not null,
  away_team text not null,
  kickoff_at timestamptz not null,
  home_score integer,
  away_score integer,
  status text not null default 'scheduled'
    check (status in ('scheduled','live','finished')),
  created_at timestamptz not null default now()
);

create table if not exists public.match_predictions (
  id uuid primary key default gen_random_uuid(),
  fixture_id uuid not null references public.fixtures(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  league_id uuid not null references public.leagues(id) on delete cascade,
  prediction text not null check (prediction in ('home','draw','away')),
  points integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (fixture_id,user_id,league_id)
);

create table if not exists public.season_predictions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  league_id uuid not null references public.leagues(id) on delete cascade,
  prediction_type text not null,
  prediction_value text not null,
  points integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id,league_id,prediction_type)
);

alter table public.fixtures enable row level security;
alter table public.match_predictions enable row level security;
alter table public.season_predictions enable row level security;

drop policy if exists fixtures_select_authenticated on public.fixtures;
create policy fixtures_select_authenticated on public.fixtures
for select to authenticated using (true);

drop policy if exists match_predictions_select_own on public.match_predictions;
create policy match_predictions_select_own on public.match_predictions
for select to authenticated using (user_id = (select auth.uid()));

drop policy if exists match_predictions_insert_own on public.match_predictions;
create policy match_predictions_insert_own on public.match_predictions
for insert to authenticated
with check (user_id = (select auth.uid()) and public.is_league_member(league_id));

drop policy if exists match_predictions_update_own on public.match_predictions;
create policy match_predictions_update_own on public.match_predictions
for update to authenticated
using (user_id = (select auth.uid()))
with check (user_id = (select auth.uid()));

drop policy if exists season_predictions_select_own on public.season_predictions;
create policy season_predictions_select_own on public.season_predictions
for select to authenticated using (user_id = (select auth.uid()));

drop policy if exists season_predictions_insert_own on public.season_predictions;
create policy season_predictions_insert_own on public.season_predictions
for insert to authenticated
with check (user_id = (select auth.uid()) and public.is_league_member(league_id));

drop policy if exists season_predictions_update_own on public.season_predictions;
create policy season_predictions_update_own on public.season_predictions
for update to authenticated
using (user_id = (select auth.uid()))
with check (user_id = (select auth.uid()));

create index if not exists fixtures_gameweek_idx on public.fixtures(gameweek);
create index if not exists fixtures_kickoff_idx on public.fixtures(kickoff_at);
create index if not exists match_predictions_user_idx on public.match_predictions(user_id);
create index if not exists match_predictions_league_idx on public.match_predictions(league_id);
create index if not exists match_predictions_fixture_idx on public.match_predictions(fixture_id);
create index if not exists season_predictions_user_idx on public.season_predictions(user_id);
create index if not exists season_predictions_league_idx on public.season_predictions(league_id);
