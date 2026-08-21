# FanRank V15

V15 connects gameweek and season predictions to Supabase.

## Setup
1. Run `fanrank-v15-predictions-schema.sql` in the Supabase SQL Editor.
2. Replace the GitHub Pages app files with the V15 files.
3. Log in and open a league.
4. Go to Predict and save predictions.
5. Check `fixtures`, `match_predictions`, and `season_predictions` in Supabase.

Predictions remain private to their owner through RLS. The leaderboard uses a secure RPC that exposes totals only.

The prototype fixtures are seeded for the current demo gameweek. Replace them later with the real fixture feed/admin workflow.
