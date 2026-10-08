# Supabase sign-up and private game stats

The game uses Supabase Auth for accounts and stores round summaries in a
Row-Level Security protected table. Email/password, Google, Microsoft (Azure),
and Apple sign-in are supported. Each account can read or add only its own
round records. Secrets and guess sequences are not stored.

## Connect a Supabase project

1. Create a project at [supabase.com](https://supabase.com/).
2. In **Project Settings → API**, copy the project URL and the public
   publishable key (or legacy `anon` key) into `supabase-config.js`. These
   browser credentials are public by design; table access is restricted by
   the SQL row security policies. Never use a `service_role` key here.
3. In **SQL Editor**, run `supabase/schema.sql`.
4. In **Authentication → URL Configuration**, set the Site URL to
   `https://nakul-pishari-4205.github.io` and add
   `https://nakul-pishari-4205.github.io/mastermind-game-pishari-nakul/`
   to the allowed redirect URLs. For a local preview, also allow the exact
   origin used by your local web server.
5. Under **Authentication → Providers**, enable Email and whichever OAuth
   providers you plan to offer. For OAuth, create an app with that provider
   and enter its client ID and client secret in the Supabase provider settings.
   Never commit OAuth client secrets to this repository.
6. In each provider's developer console, add Supabase's callback URL shown on
   the provider settings page as an authorized redirect URI. Google uses its
   OAuth web client, Microsoft uses the Azure provider, and Apple requires an
   Apple Services ID and Sign in with Apple configuration.
7. Commit and publish the updated `supabase-config.js` so the hosted page can
   connect. Test registration, email confirmation, sign-in and sign-out on the
   deployed HTTPS site.

Email confirmation can be enabled in Supabase Auth. When enabled, new users
must confirm their email before signing in. OAuth setup and provider account
requirements are managed by their respective providers.

## Saved data and privacy

The site records the difficulty, game mode, win/loss, guesses used and date for
each completed round. It does not store secret codes or individual guesses.
Rows are keyed to the authenticated Supabase user, and the policies in
`supabase/schema.sql` restrict both reads and inserts to that user. The page
shows account-wide round and win totals after sign-in.
