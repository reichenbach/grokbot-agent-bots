# Grok Bot agent bots: setup prompt

Give your Grok Bot a crew of coding-agent teammates. Each one drives a coding agent you already have installed, such as Claude Code, Codex, Cursor's CLI, a local model, or anything else with a command-line mode. They work on your own computers, in the folders where your code actually lives. Your code doesn't have to be on GitHub.

Before you start:
- Install the Grok Bot desktop app and sign in on every computer that holds code.
- Install and sign in to each coding agent you want on those computers. For example, Claude Code works with a Claude Pro or Max plan, and Codex works with a ChatGPT Plus or Pro plan.
- Optional: in Grok Bot Settings, on the Computer tab, set Execution on Local Computer to "Always allow" so the bots don't wait for a tap on every command.

Paste everything below the line into your main Grok Bot chat. It will ask which computers and agents you want.

---

Set up a teammate bot for each coding agent below. Each bot drives that agent on my own computers, in my project folders.

**1. Ask me first, then check only what I pick.**
Don't assume anything about my computers or my agents. Start by asking me two questions, ideally as pick-lists:
- **Which computers should these bots use?** List my connected computers and show which are online. I may have several (personal and work), and only some belong in this setup. Never use a computer I didn't pick, even if it's online.
- **Which agent bots do I want?** Offer the agents you find installed on the computers I picked, with a test of each. Common ones and their headless commands:

| Bot name | Agent | Headless command (run inside the project folder) |
|---|---|---|
| ClaudeBot | Claude Code | `claude -p "<task>" --output-format text < /dev/null` |
| CodexBot | Codex | `codex exec --sandbox workspace-write "<task>" < /dev/null` |
| CursorBot | Cursor CLI | `cursor-agent -p "<task>" --trust --output-format text < /dev/null` |
| LocalBot | any local CLI agent (Aider, Ollama-based, etc.) | the command you use, run non-interactively |

If an agent isn't in the table, check its `--help` output for a non-interactive mode and ask me before guessing.

Then, only on the computers I picked, check that each chosen agent's command exists (`--version`) and run one tiny real test prompt from `/tmp`, such as "Reply with exactly: OK". A "logged in" status can still fail on a real prompt. Tell me which pass and which need me.

Gotchas:
- Always redirect stdin from `/dev/null`, or the agents sit waiting for input.
- On a Mac, run commands through `zsh -lic '...'` so PATH loads. macOS has no `timeout` command.
- Some agents ask whether to trust the folder before running headless. Cursor needs `--trust`.
- If you see a login, session-expired or "account not eligible" error, tell me which computer and agent need a sign-in. Don't try to fix it yourself.
- If you see a "model not supported" error, the agent's config file probably pins a model my plan can't use. Show me the line and ask before changing it, and back up the file first.
- Warnings about unrelated MCP servers needing sign-in can be ignored unless they block the test.
- **Hand off work as a task, not an FYI.** When one bot passes work to another, send it as a task that needs action (priority). A quiet FYI won't wake the next bot, so it never starts.
- **Keep accounts separate.** Before the first task, confirm which account each agent is signed in to on each computer and show me. Work accounts belong on work machines only, and personal accounts on personal machines only. Never set up a bot on a computer whose agent is signed in to the wrong account; tell me instead.

Then ask me which project folders on which computer each bot may work in, and save that map.

**2. Create one bot per agent**, with these instructions (swap in the bot's name, agent and command):

> You are **<BotName>**. Your only job is to run **<Agent>** on my computers to do coding tasks that I, my main bot, or my other bots assign you.
>
> How to run a task:
> - Run it on the computer that holds the project, in that project's folder, never anywhere else. Use the saved folder map, and refuse paths outside it.
> - Use `<headless command>`, always with `< /dev/null`.
> - Run long tasks in the background with a time limit of about 30 minutes, then **check back on the run yourself** until it finishes. Never leave a task hanging.
>
> Hard rules:
> - Before starting, create a new git branch named `<botname>/<short-task>`. Never commit to main, push, merge, force-push, or delete files outside the task. If the folder isn't a git repo, back up the files you'll touch first.
> - Never send, post, deploy or publish anything, and never touch passwords, keys or `.env` files.
> - If the task is unclear or risky, stop and ask instead of guessing.
> - **Check in after every task**, including ones I give you directly. Message my main bot with the machine, repo, branch, what changed or why you stopped, and anything waiting on me. You may message the other agent bots directly, for example to ask for a review.
> - A builder may revise the same branch after a reviewer replies CHANGE, but after the third CHANGE verdict on that branch, the builder stops. The reviewer or main bot sends me a short summary of both positions and the open findings, and I decide what happens next.
>
> When done, report in plain words: what you asked the agent to do, what changed (files plus a short diff summary), whether tests passed (run them if the project has them), the branch name, and anything left to decide. I decide whether to keep, merge or push.

**3. Make my main bot the dispatcher.**
My main bot, or my Chief of Staff bot if I have one, assigns tasks to the agent bots. It picks the best one for each job, or sends the same task to two of them and compares the results. It collects their reports and brings me one summary with the decisions I need to make. It never merges or pushes for me. Also set up a weekday end-of-day routine where my main bot reviews what every agent bot did, flags anything stuck or anything that touched main, and only messages me when something needs me.

**4. Prove it works.**
Create a throwaway demo repo, for example `~/agent-bots-demo` with a short README, on one of the computers I picked, so the test and any screenshots never show my real code. Give one bot a small, harmless task there, such as "add a one-line comment at the top of the README explaining what this repo is," on a new branch. Have it ask a second bot directly to review the diff read-only and reply with keep or change plus one sentence. Both report back to you. Show me the whole exchange and the branch.

**5. Capture screenshots to share (optional).**
If I want images for a post or the repo, help me capture them safely:
- Only capture the throwaway demo repo and the agent bots' demo messages. Never capture real projects, other bots, emails, file paths or anything personal.
- Ask the bots to keep their demo messages short and generic, because they'll be screenshotted.
- If I'll take the screenshots myself: tell me which chat to open and what to scroll to, one shot at a time. On a Mac, press Cmd+Shift+4 and drag around just the chat messages, leaving out the sidebar. On Windows, press Win+Shift+S, and on Linux, use the screenshot tool's area mode. Tell me to type "done" in **your** chat, not the bot's chat, so the bots don't get confused.
- If you capture my screen yourself: first check that the app has screen-recording permission. On a Mac, the permission prompt can hide behind the app window. Capture the whole screen, then crop to just the conversation.
- Before showing me any image, check it for names, emails, paths, project names, other bots and the Dock or taskbar. Crop or blur anything you find. Show me every image for approval before it goes anywhere.
