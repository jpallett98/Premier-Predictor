# FanRank V10

The interface is intentionally unchanged.

V10 begins the backend transition:
- Centralised FanRankDB data layer
- User/profile storage abstraction
- League storage abstraction
- Prediction storage abstraction
- Backend schema for users, leagues, members, predictions and results
- Existing prototype remains playable locally

Important:
This version is NOT yet a real multiplayer backend. Data is still stored locally on the device. The next backend step is to connect FanRankDB to a hosted database/authentication service so multiple devices can share the same leagues and predictions.
