# jmu-cs445-devcontainer

This repo builds and publishes the course container image for CS445 to
`ghcr.io/spragunr/jmu-cs445-devcontainer:latest`. Pushing to `main`
triggers the GitHub Actions workflow that rebuilds and pushes the image.

## Making the image public

After the first successful Actions run, the package is private by default.
Make it public so assignment repos can pull it without authentication:

https://github.com/users/spragunr/packages/container/jmu-cs445-devcontainer/settings
→ **Change visibility → Public**

---

## Codespaces billing — what the education benefit actually covers

The **GitHub Team plan through education** covers:
- ✅ **Actions minutes** (3,000/month for the org) — prebuild builds are free
- ❌ **Codespaces storage** — prebuild cache storage is billed at ~$0.07/GB-month and is NOT covered by the education org benefit
- ❌ **Codespaces compute at the org level** — not included in the Team plan

**Personal accounts** (verified educator/student) get the GitHub Pro equivalent:
- ✅ 180 core-hours/month of Codespaces compute
- ✅ 20 GB/month of Codespaces storage
These are personal-account benefits only, not org-level.

**Bottom line:** if Codespaces are billed to the org, expect a small but real
storage charge for prebuilds (~$0.07/GB-month per prebuild). Set a spending
limit as a hard cap.

---

## Codespaces delivery options

### Option 1 — Prebuilds (fast startup, small storage cost)

Prebuilds cache the fully-built container so new Codespaces start in ~10–30
seconds instead of minutes. Requires:
- GitHub Team plan ✅ (covered by education benefit)
- A payment method on the org
- A non-zero spending limit (e.g. $5–10/month as a hard cap) — required even
  though education benefits cover most actual costs

**One-time org setup:**

1. Add a payment method:  
   https://github.com/organizations/JMU-CS445-fall2026/settings/billing/payment_information

2. Set a Codespaces spending limit:  
   https://github.com/organizations/JMU-CS445-fall2026/settings/billing/spending_limit

3. Bill Codespaces to member accounts (not the org) so students use their own
   free personal quota rather than the org's:  
   https://github.com/organizations/JMU-CS445-fall2026/settings/codespaces

**Per-repo prebuild setup:**

4. Go to `https://github.com/JMU-CS445-fall2026/<repo>/settings/codespaces`  
   → **Set up prebuild** → branch `main` → save. An Actions workflow builds
   the prebuild; subsequent Codespaces on that repo start in seconds.

5. To keep storage costs low: delete old prebuilds as assignments wrap up, and
   configure prebuilds to build for one region only (US East).

### Option 2 — One Codespace per student, reused all semester (free)

Skip prebuilds entirely. Point students to a single generic course environment
repo. They create one Codespace at the start of term and reuse it for every
assignment by uploading the starter notebook and downloading the completed one.

- ✅ Completely free — no prebuild storage, students use their personal quota
- ⚠️ First launch is slow (full image pull, ~2–5 min)
- ⚠️ GitHub deletes inactive Codespaces after 30 days — students must keep
  theirs active or risk losing work
- ⚠️ No automatic assignment scaffolding — students upload files manually

### Option 3 — Anaconda + environment.yml (free, offline, simplest backup)

Students install Anaconda once and run `conda env create -f environment.yml`.
Works natively on all platforms including Apple Silicon. No Docker, no WSL2,
no browser required.

- ✅ Free, no quotas, no expiry
- ✅ One familiar installer, one command — simpler than Docker for most students
- ✅ Works natively on Apple Silicon (no emulation slowness)
- ✅ Files live on student's machine
- ⚠️ Minor environment differences possible across OS (rarely a real problem)
- ⚠️ Students manage their own package environment

The `environment.yml` lives in this repo. Assignment READMEs link directly to
the raw file so students can download it without cloning this repo.

**Recommended approach:** Codespaces as the primary path (Option 1 or 2);
Anaconda as the backup for students who hit Codespaces issues or want to
work offline. Local Dev Containers is not worth recommending — more setup
friction than either option for no meaningful benefit in a course context.

---

## Updating the environment

Edit `environment.yml`, commit, and push. The Actions workflow rebuilds the
image automatically. If using prebuilds, delete and recreate them on affected
assignment repos so students get the updated image.
