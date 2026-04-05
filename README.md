# openclaw-terse-gpt54

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

## Rules that matter

- answer first
- default short
- expand only when needed
- remove praise, recap, and prompt-echo
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
