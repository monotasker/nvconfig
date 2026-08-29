-- Kulala pre-request include: decrypt *all* env.secrets (one touch each).
-- Prefer named inject in the request instead:
--   require("nvconfig.kulala.simplesec").inject("KC_API_KEY")
require("nvconfig.kulala.simplesec").inject_secrets()
