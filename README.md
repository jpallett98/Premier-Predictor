# FanRank V12

Authentication-first app flow.

First launch:
1. Welcome screen
2. Log in or Create Account
3. Account setup includes name, email, password and favourite team
4. Successful authentication opens the Home dashboard

Returning user:
- Existing local session opens directly to Home
- Sign out returns to the authentication screen

Also included:
- Sign-out control
- Input validation
- Favourite-team selection
- Existing FanRank interface retained after login

Important: this is still local demo authentication. Passwords are not stored. A real hosted authentication backend must replace this local session layer before production.
