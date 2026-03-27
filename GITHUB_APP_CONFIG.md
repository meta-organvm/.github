# GitHub App Configuration: meta-organvm-cross-org

**Last Updated:** 2026-02-26T18:29:54.891Z

## Overview

The `meta-organvm-cross-org` GitHub App enables cross-organization automation and CI/CD orchestration across the 8-organ system enterprise.

## App Credentials

**All credentials stored in 1Password → GitHub-Tokens vault**

| Field | Value | 1Password Reference |
|-------|-------|-----------|
| **App ID** | `2958047` | op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/app_id |
| **Client ID** | `Iv23liN5op3fxVRtJgAp` | op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/client_id |
| **Client Secret** | `9aad30e3f85aae0a7fee961abc8d8519644415a4` | op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/client_secret |
| **Private Key** | (See 1Password) | op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/private_key |
| **Webhook Secret** | `ea504da70f6cc2cd73c47b63330fd61d3e812374f4a43a4126d698ba13bc1b2f` | op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/webhook_secret |

## Webhook Configuration

| Setting | Value |
|---------|-------|
| **Webhook URL** | `https://symbolistical-amiya-mitigable.ngrok-free.dev/github/webhook` |
| **Webhook Secret** | `ea504da70f6cc2cd73c47b63330fd61d3e812374f4a43a4126d698ba13bc1b2f` |
| **SSL Verification** | Enabled |
| **Active** | Yes |

## Subscribed Events

- `push`
- `pull_request`
- `workflow_run`

## Installation Status

| Organization | Installation ID | Status |
|--------------|-----------------|--------|
| `meta-organvm` | `112680405` | ✅ Installed |
| `organvm-i-theoria` | TBD | ⏳ Pending |
| `organvm-ii-poiesis` | TBD | ⏳ Pending |
| `organvm-iii-ergon` | TBD | ⏳ Pending |
| `organvm-iv-taxis` | TBD | ⏳ Pending |
| `organvm-v-logos` | TBD | ⏳ Pending |
| `organvm-vi-koinonia` | TBD | ⏳ Pending |
| `organvm-vii-kerygma` | TBD | ⏳ Pending |

## Environment Variables

```bash
GITHUB_APP_ID=2958047
GITHUB_APP_CLIENT_ID=Iv23liN5op3fxVRtJgAp
GITHUB_WEBHOOK_SECRET=ea504da70f6cc2cd73c47b63330fd61d3e812374f4a43a4126d698ba13bc1b2f
```

## Retrieving Credentials from 1Password

```bash
op read "op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/app_id"
op read "op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/client_secret"
op read "op://GitHub-Tokens/GitHub App: meta-organvm-cross-org/private_key"
```

## References

- GitHub App Settings: https://github.com/organizations/meta-organvm/settings/apps/meta-organvm-cross-org
- Webhook Handler: `system-dashboard/src/dashboard/routes/github_app.py`
- 1Password Vault: `GitHub-Tokens` → `GitHub App: meta-organvm-cross-org`
