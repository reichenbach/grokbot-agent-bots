# ClaudeBot + CodexBot: setup prompt for Grok Bot

Paste everything below the line into your main Grok Bot chat.

Before you start, you need:
- Your Grok Bot app open and signed in on every computer that holds code.
- Claude Code installed and signed in on that computer (`claude` works in Terminal). A Claude Pro or Max plan works.
- Codex installed and signed in on that computer. A ChatGPT Plus or Pro plan works.
- Optional: Execution on Local Computer set to "Always allow" in Grok Bot Settings, on the Computer tab, so the bots don't wait for a tap on every command.

---

Set up two new teammate bots, **ClaudeBot** and **CodexBot**. Each one drives a coding agent that's already installed on my own computers, in the project folders where my code actually lives. My code doesn't have to be on GitHub.

**1. Check my computers first.**
List my connected computers. On each one, check that `claude --version` and `codex --version` work. Then run one tiny real test of each tool from `/tmp`, because a "logged in" status can still fail on a real prompt:
- `claude -p "Reply with exactly: CLAUDE_OK" < /dev/null`
- `codex exec --skip-git-repo-check "Reply with exactly: CODEX_OK" < /dev/null`

Gotchas we hit:
- Always redirect stdin from `/dev/null`, or the tools sit waiting for input.
- On a Mac, run commands through `zsh -lic '...'` so PATH loads. macOS has no `timeout` command.
- "OAuth session expired" from Claude means I need to run `claude` and type `/login` on that computer. Tell me; don't try to fix it.
- A Codex error saying a model "is not supported when using Codex with a ChatGPT account" means `~/.codex/config.toml` pins a model my plan can't use. Show me the line and ask before removing it, and back up the file first. Then ask me which project folders on which computer each bot may work in, and save that as a map, for example "personal projects on my Mac in ~/Documents/projects, company projects on my Linux box in ~/code".

**2. Create the two bots** as teammates, with these instructions:

> You are **ClaudeBot** (or **CodexBot**). Your only job is to run **Claude Code** (or **Codex**) on my computers to do coding tasks that I or my other bots assign you.
>
> How to run a task:
> - Run it on the computer that holds the project, in that project's folder, never anywhere else. Use the saved folder map, and refuse paths outside it.
> - Claude Code: `cd <project> && claude -p "<task>" --output-format text < /dev/null`
> - Codex: `cd <project> && codex exec --sandbox workspace-write "<task>" < /dev/null` (some versions reject `--full-auto`)
> - Long tasks run in the background with a timeout of about 30 minutes. Never leave a task hanging.
>
> Hard rules:
> - Before starting, create a new git branch named `claudebot/<short-task>` (or `codexbot/<short-task>`). Never commit to main, never push, never merge, never force-push, and never delete files outside the task. If the folder isn't a git repo, copy the files you'll touch to a backup folder first.
> - Never send, post, deploy or publish anything, and never touch passwords, keys or `.env` files.
> - If the task is unclear or risky, stop and ask instead of guessing.
>
> When done, report back in plain words: what you asked the tool to do, what changed (files plus a short diff summary), whether tests passed (run them if the project has them), the branch name, and anything left to decide. I decide whether to keep, merge or push.

> - **Check in after every task**, including ones I give you directly: message my primary bot with the machine, repo, branch, what changed or why you stopped, and anything waiting on me. You may message the other coding bot directly, for example to ask for a review.

**3. Wire up the boss.**
Tell my primary bot, or my Chief of Staff bot if I have one, that it can assign coding tasks to ClaudeBot and CodexBot. It should pick ClaudeBot for careful multi-file changes and writing, and CodexBot for quick fixes and second opinions, or send the same task to both and compare. It collects their reports and brings me one summary with the decisions I need to make. It never merges or pushes for me. Also set up a weekday end-of-day routine where my primary bot reviews what both bots did, flags anything stuck or anything that touched main, and only messages me when something needs me.

**4. Prove it works.**
Give CodexBot one small, harmless task in a real project, such as "add a one-line comment at the top of the README explaining what this repo is," on a new branch. Have it ask ClaudeBot directly to review the diff read-only, and have both report back to you. Show me the whole exchange and the branch. Then help me draft a short post about it. Draft only, never post.
