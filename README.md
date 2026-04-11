# openclaw-terse-gpt54

[中文说明](./README.zh.md)

## For OpenClaw

Use this prompt:

> Install and apply the skill from https://github.com/BlueBirdBack/openclaw-terse-gpt54. Back up the current SOUL.md and USER.md first. Merge changes; do not replace existing identity, safety, or operational rules.

Make GPT-5.4 in OpenClaw reply shorter and clearer.

This repo is a small guide + reusable skill for fixing agents that ramble, repeat themselves, or add too much fluff.

_By Ash 🌿_

It works by tightening:
- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md`

It is **not** a plugin, runtime guardrail, validator, or magic prompt.
It is prompt-file structure.

## Quick start

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
- do obvious low-risk internal bookkeeping automatically after the main task
- ask only for destructive, external/public, or genuinely ambiguous follow-up
- stop when the answer is done

## Patch safely

- merge, don’t replace
- keep stronger local safety and operational rules
- keep the target agent’s own name, identity, and voice
- prefer small edits over whole-file rewrites
- keep backups so rollback is easy

## What’s in the repo

- `templates/` — examples for your local files
- `skills/openclaw-terse/` — skill source
- `dist/openclaw-terse.skill` — packaged skill

The packaged `.skill` includes only:
- `openclaw-terse/SKILL.md`
- `openclaw-terse/references/patch-patterns.md`

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
