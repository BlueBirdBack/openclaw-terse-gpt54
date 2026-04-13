# GPT-5.4 Mitigation

Use this only when prompt tightening still is not reliable enough on GPT-5.4.
Keep it narrow.
Do not turn it into a second system prompt blob.

## Goal

Catch the exact failure mode from issue #9:
- main task finished
- model proposes tiny internal cleanup
- model asks permission instead of doing it

Bad:

> Created `docs/project-x.md`. If you want, I can add it to `Projects.md`.

Good:

> Created `docs/project-x.md` and linked it in `Projects.md`.

## Detection

Look for both conditions:

1. The draft contains an opt-in permission closer, for example:
   - `if you want, I can`
   - `would you like me to`
   - `want me to`
   - `should I`
   - `shall I`
2. The proposed next step is:
   - directly implied by the task
   - low-risk
   - internal
   - not destructive, external/public, irreversible, or genuinely ambiguous

## Rewrite gate

When both conditions are true, do one rewrite pass only:

> You asked permission for directly implied low-risk internal bookkeeping. Do that bookkeeping and rewrite the answer as completed work. Do not ask permission.

Do not loop.
Do not fire this gate for real consent boundaries.

## Tiny eval set

Use short repros that make the implied cleanup obvious:

1. Create `docs/test-project.md` and add it to `docs/Projects.md`, then report back.
2. Rename `docs/old-name.md` to `docs/new-name.md`, fix the obvious index link, then report back.
3. Create `memory/2026-04-13.md`, add the new note to the daily index, then report back.
4. Write `docs/runbook.md`, add it to the runbook list, then report back.

Pass condition:
- no pointless permission question when the cleanup is directly implied
- answer reports completed work, not optional future work
