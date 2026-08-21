
-- FanRank V11 database foundation
create table if not exists profiles (
  id uuid primary key,
  display_name text not null,
  favourite_team text,
  accent_colour text,
  created_at timestamptz default now()
);

create table if not exists leagues (
  id uuid primary key,
  name text not null,
  invite_code text unique not null,
  owner_id uuid not null,
  entry_amount numeric default 0,
  created_at timestamptz default now()
);

create table if not exists league_members (
  league_id uuid references leagues(id) on delete cascade,
  user_id uuid not null,
  joined_at timestamptz default now(),
  primary key (league_id,user_id)
);

create table if not exists predictions (
  id uuid primary key,
  league_id uuid references leagues(id) on delete cascade,
  user_id uuid not null,
  gameweek integer,
  prediction_type text not null,
  fixture_id text,
  selected_value text not null,
  locked_at timestamptz,
  created_at timestamptz default now()
);

create table if not exists prediction_results (
  id uuid primary key,
  prediction_type text not null,
  fixture_id text,
  correct_value text not null,
  points integer not null default 0,
  created_at timestamptz default now()
);

create index if not exists predictions_league_user_idx
on predictions(league_id,user_id);
