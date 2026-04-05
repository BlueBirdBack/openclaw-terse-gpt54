# openclaw-terse-gpt54

Make `openai-codex/gpt-5.4` in OpenClaw reply with less fluff.

This repo improves behavior through **prompt structure and file layout**.
It does **not** add runtime enforcement, validators, hooks, or reply linting inside OpenClaw itself.

This is **not** one magic prompt.
It is a small stack:

1. tighten `SOUL.md`
2. move user-specific prefs into `USER.md`
3. add `RESPONSE_PROTOCOL.md` as a reply checklist
4. add a prompt-side **Response Gate** checklist
5. keep memory lean enough to trust

## What worked

### 1) Make brevity explicit

Do not say "be concise" once and hope.
Say:

- **Default short. Depth only on request.**
- **Answer first.**
- **No fluff, praise, recap, or prompt-echo.**
- **Stop once the job is done.**

### 2) Separate identity from preferences

Keep the soul clean.

- `SOUL.md` = identity, style, response discipline
- `USER.md` = user-specific working preferences
- `RESPONSE_PROTOCOL.md` = compact reply checklist

### 3) Add a prompt-side response gate

Before every reply, use this checklist:

- Is the answer in the first line?
- Can this be 1 short paragraph or 3–5 bullets?
- Did I remove praise, recap, prompt-echo, and filler?
- Did I cut at least one non-essential sentence?
- Once the job is done, did I stop?

### 4) Patch behavior, not adjectives

"Be concise" is weak.

These are stronger:

- answer first
- default short
- depth only on request
- no repeated point in new wording
- silence beats padding

### 5) Start a fresh session after patching

A fresh `/new` helps because the updated files become the clean baseline from turn one.

## Files to edit in OpenClaw

- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md` *(new or tightened)*
- optional: `MEMORY.md` / daily memory if you want to record the preference permanently

## Safe patching rules

- **Merge, don’t replace.**
- Preserve stronger local safety, escalation, and operational constraints.
- Prefer targeted section edits over whole-file rewrites.
- Keep backups before editing.
- Keep diffs small and rollback easy.
- Replace a whole file only if the user explicitly asks.

## Included in this repo

- `templates/` — manual templates and examples to adapt into local files
- `skills/openclaw-terse/` — source for the packaged skill
- `dist/openclaw-terse.skill` — packaged artifact containing only:
  - `openclaw-terse/SKILL.md`
  - `openclaw-terse/references/patch-patterns.md`

The packaged `.skill` does **not** include `templates/`.

## Install the idea manually

1. back up `SOUL.md` and `USER.md`
2. patch the existing files using the patterns from `templates/`
3. create or tighten `RESPONSE_PROTOCOL.md`
4. start a fresh session
5. test on 3 real prompts
6. tighten again if it still rambles

## Packaging and verification

Build the packaged skill:

```bash
bash scripts/build-skill.sh
```

Verify that `dist/openclaw-terse.skill` matches source:

```bash
bash scripts/verify-skill.sh
```

The build script writes a SHA-256 checksum to `dist/openclaw-terse.skill.sha256`.
The verify script rebuilds the artifact in a temp directory and fails if it drifts from source.

## Compatibility

Assumes an OpenClaw workspace that uses `SOUL.md` and `USER.md`.
If your setup differs, adapt the patterns manually.

## Why this works

GPT-5.4 is capable, but it likes to elaborate.
You do not fix that with vibes.
You fix it with **structure**.

## Skill

The bundled skill is for requests like:

- "make this OpenClaw agent less verbose"
- "tighten the soul"
- "GPT-5.4 is too chatty"
- "make replies short and direct"

It tells the agent to:

- back up current files
- harden `SOUL.md`
- keep user preferences in `USER.md`
- create or tighten `RESPONSE_PROTOCOL.md`
- add a prompt-side response checklist
- avoid bloating memory

## License

MIT
