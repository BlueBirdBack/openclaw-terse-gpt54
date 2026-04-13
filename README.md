# openclaw-direct-gpt54

[中文说明](./README.zh.md)

## For OpenClaw

Use this prompt:

> Install and apply the latest version of this skill from https://github.com/BlueBirdBack/openclaw-direct-gpt54. Back up my current `SOUL.md` and `USER.md` first. Merge changes; do not replace my identity, safety, or operational rules.

Make GPT-5.4 in OpenClaw reply shorter and clearer.

This repo provides prompt-side guidance, a reusable skill, and GPT-5.4-specific reference patterns for fixing agents that ramble, repeat themselves, or add too much fluff.

_By Ash 🌿_

It works by tightening:
- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md`

It is **not** a plugin, runtime guardrail, validator, or magic prompt.
It is prompt-file structure.

## Quick start (default path)

1. Prefer installing the packaged `dist/openclaw-terse.skill`.
2. Follow the skill to merge changes into local `SOUL.md`, `USER.md`, and `RESPONSE_PROTOCOL.md`.
3. Start a fresh session.
4. Test a few real prompts.

## Manual path (when not installing the skill directly)

1. Back up `SOUL.md` and `USER.md`.
2. Use `templates/` to patch `SOUL.md`, `USER.md`, and `RESPONSE_PROTOCOL.md`.
3. Start a fresh session.
4. Test a few real prompts.

## Minimal adoption path

Not every agent needs all three files patched.
Start small:

1. **Smallest:** Add `Response Discipline` + `Response Gate` to `SOUL.md` only.
2. **Typical:** Patch `SOUL.md` + add `RESPONSE_PROTOCOL.md`.
3. **Full:** Patch all three files.

Test after each step. Only expand if the smaller change is not enough.

## Update this skill

Use this prompt:

> Install and apply the latest version of this skill from https://github.com/BlueBirdBack/openclaw-direct-gpt54. Back up my current `SOUL.md` and `USER.md` first. Merge changes; do not replace my identity, safety, or operational rules.

## Rollback

```bash
cp SOUL.md.bak SOUL.md
cp USER.md.bak USER.md
cp RESPONSE_PROTOCOL.md.bak RESPONSE_PROTOCOL.md  # only if it existed before
```

Then start a fresh session to flush old context.
Only delete `RESPONSE_PROTOCOL.md` entirely if it did not exist before the patch.

## Rules that matter

- answer first
- default short
- expand only when needed
- remove praise, recap, and prompt-echo
- never ask permission for directly implied low-risk internal bookkeeping after the main task; do it, then report it
- if you created a durable artifact that obviously belongs in an index or tracker, update that index or tracker before replying
- ask only for destructive, external/public, or genuinely ambiguous follow-up
- stop when the answer is done

## Concrete behavior target

Bad:

> Created `docs/project-x.md`. If you want, I can add it to `Projects.md`.

Good:

> Created `docs/project-x.md` and linked it in `Projects.md`.

The difference is small, but the friction is real.
Internal bookkeeping that is directly implied by the task should happen before the reply, not be handed back to the user as another decision.

## GPT-5.4 reality check

Prompt tightening improves the odds, but it is not a hard fix for GPT-5.4.
This repo ships prompt-side guidance and reusable skill / reference patterns; it does not directly ship a runtime rewrite gate implementation.
If GPT-5.4 still leaks "If you want, I can..." style permission questions, pair this skill with a narrow runtime rewrite gate:

- detect opt-in permission closers
- only fire when the follow-up is directly implied low-risk internal bookkeeping
- rewrite once as completed work
- never fire for destructive, external/public, irreversible, or genuinely ambiguous follow-up

See `skills/openclaw-terse/references/gpt54-mitigation.md` for a compact pattern.

## Patch safely

- merge, don’t replace
- keep stronger local safety and operational rules
- keep the target agent’s own name, identity, and voice
- prefer small edits over whole-file rewrites
- keep backups so rollback is easy

## Why the repo name and skill name differ

- The repo is now named `openclaw-direct-gpt54`
- The shipped skill and package name are still `openclaw-terse` / `openclaw-terse.skill`
- That is a conservative compatibility choice for existing references, package names, and trigger behavior

## What’s in the repo

- `templates/` — examples for your local files
- `skills/openclaw-terse/` — skill source (the current skill id is still `openclaw-terse`)
- `dist/openclaw-terse.skill` — packaged skill

The packaged `.skill` includes:
- `openclaw-terse/SKILL.md`
- `openclaw-terse/references/patch-patterns.md`
- `openclaw-terse/references/gpt54-mitigation.md`

## Build / verify

Requires:
- `zip`
- `sha256sum`

```bash
bash scripts/build-skill.sh
bash scripts/verify-skill.sh
```

## Compatibility

Assumes an OpenClaw workspace that uses `SOUL.md` and `USER.md`.
If yours differs, adapt the patterns manually.

## License

MIT
