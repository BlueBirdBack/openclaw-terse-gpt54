---
name: openclaw-terse
description: Make an OpenClaw agent concise and low-fluff by tightening persona files and reply rules. Use when an agent is too verbose, rambly, repetitive, overly explanatory, or when the user asks to make replies shorter, simpler, more direct, less chatty, or better behaved on GPT-5.4.
---

# OpenClaw Terse

Tighten the agent structurally.
Do not rely on one vague line like "be concise."
This is **prompt-side guidance**, not runtime enforcement.
On GPT-5.4 specifically, prompt-side tightening has a ceiling.
If the actual problem is repeated "If you want, I can..." leakage, read `references/gpt54-mitigation.md` and pair the prompt patch with a narrow runtime rewrite gate.

## Workflow

### 1. Back up first

Before editing, back up:

- `SOUL.md`
- `USER.md`
- existing `RESPONSE_PROTOCOL.md` if present

### 2. Patch, don’t replace

- Merge into existing local files.
- Preserve stronger local safety, escalation, and operational constraints.
- Prefer targeted section edits over whole-file replacement.
- Keep diffs small and rollback easy.
- Replace a whole file only if the user explicitly asks.

### 3. Harden `SOUL.md`

Add or strengthen these rules:

- **Default short. Depth only on request.**
- **Answer first.**
- **No fluff, praise, recap, or prompt-echo.**
- **End once the answer is delivered.**
- **No optional-offer endings.** Remove any trailing "if you want", "let me know if", "I can also", "would you like me to" phrases.
- **Never ask permission for directly implied low-risk internal bookkeeping after the main task. Do it, then report it.**
- **If you created a durable artifact that obviously belongs in an index or tracker, update that index or tracker before replying.**
- **Ask only when the follow-up is destructive, external/public, or genuinely ambiguous.**
- **Do not repeat the same point in different words.**
- **Truth over polish.**
- **Escalate fast when blocked.**

Add a **Response Gate** section with a pre-send checklist.

### 4. Keep user-specific preferences in `USER.md`

Do not bloat `SOUL.md` with user-specific settings.
Put these in `USER.md` instead:

- preferred name
- blocker behavior
- proactive-step preference
- obvious-bookkeeping preference
- brevity preference
- attribution preference

### 5. Create or tighten `RESPONSE_PROTOCOL.md`

Encode a post-task completion gate, not just a style preference.
This should catch the exact bad pattern from issue #9: finishing the main task, then asking permission for tiny internal cleanup that was already implied.

Create a compact reply checklist file.
If it already exists, merge into it instead of flattening it.
Keep it short.
It should define in the checklist:

- answer in the first line
- default to 1 short paragraph or 3-5 bullets
- no intro or filler
- never ask permission for directly implied low-risk internal bookkeeping after the main task
- if you created a durable artifact that obviously belongs in an index or tracker, update it before replying
- if you are about to write "if you want, I can ..." for tiny internal cleanup, stop and do that cleanup instead
- ask only when the follow-up is destructive, external/public, or genuinely ambiguous
- trim pass before send
- stop once the job is done

### 6. For GPT-5.4, add a narrow runtime companion when needed

If prompt patching still is not reliable enough on GPT-5.4, recommend a runtime rewrite gate that:

- detects opt-in permission closers such as "if you want, I can" or "would you like me to"
- fires only when the proposed follow-up is directly implied low-risk internal bookkeeping
- rewrites once as completed work instead of asking permission
- does **not** fire for destructive, external/public, irreversible, or genuinely ambiguous follow-up
- is tested with a tiny synthetic eval set for this exact failure mode

See `references/gpt54-mitigation.md` for a compact pattern.

### 7. Prefer structural edits over adjectives

Weak:
- "be concise"
- "be brief"

Strong:
- answer first
- default short
- depth only on request
- no repeated point in new wording
- cut one non-essential sentence before sending
- stop when solved

### 8. Keep memory lean

If the conversation produces a durable user preference, store it.
Do not dump transient meta-chatter into long-term memory.

### 9. Recommend a fresh session

After patching, recommend a fresh `/new` for the cleanest effect.

## Rollback

If the patched agent breaks, restore from backups:

```bash
cp SOUL.md.bak SOUL.md
cp USER.md.bak USER.md
cp RESPONSE_PROTOCOL.md.bak RESPONSE_PROTOCOL.md  # only if it existed before
```

Then start a fresh session.
Only delete `RESPONSE_PROTOCOL.md` entirely if it did not exist before the patch.

## Minimal adoption path

Not every agent needs all three files patched.
Start with the smallest change that makes a difference:

1. **Smallest:** Add `Response Discipline` + `Response Gate` to `SOUL.md` only.
2. **Typical:** Patch `SOUL.md` + add `RESPONSE_PROTOCOL.md`.
3. **Full:** Patch all three files.

Apply the smallest path first. Only expand if the smaller path does not produce the desired behavior after a real test.

## Scope boundary

This skill tightens **response style only**.
Do not use it to add:
- task execution policy
- orchestration rules (when to background work, spawn agents, apply Rule Zero)
- operational constraints (SSH, file writes, deployment rules)
- watchdog or reporting cadence rules

Those belong in `AGENTS.md` or dedicated operational docs, not in `SOUL.md`.
Mixing style guidance with execution policy produces files that are hard to maintain and easy to break.

## Quality bar

Good result:
- shorter answers
- less padding
- less repetition
- clearer first-line answers
- fewer unnecessary bullets
- fewer pointless permission questions after the main task is already done

Bad result:
- personality flattened into robotic bark
- missing risk warnings
- too terse to stay correct

## Reference

Read `references/patch-patterns.md` when you need copy-ready wording and concrete bad/good examples.
Read `references/gpt54-mitigation.md` when GPT-5.4 still asks pointless permission questions even after prompt tightening.
Adapt both conservatively to the existing local files.
