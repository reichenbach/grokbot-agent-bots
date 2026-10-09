# Grok Bot agent bots

Give your Grok Bot a crew of coding-agent teammates: one bot per coding agent you already use. That can be Claude Code, Codex, Gemini CLI, a local model, or anything with a command-line mode.

They work **on your own computers, in your local project folders**. Your code doesn't need to be on GitHub. Your main Grok Bot assigns tasks. Each agent bot creates a branch, runs its agent, can ask another bot for a review, and checks in after every task. Nothing is pushed, merged or posted without your OK.

It's a human-in-the-loop setup: you approve, the agents do the work.

## Use it

1. Install the Grok Bot desktop app on each computer that holds code, and sign in.
2. Install the coding agents you want there and sign in to each.
3. Open [SETUP_PROMPT.md](SETUP_PROMPT.md), edit the agent list, and paste everything below its line into your main Grok Bot chat.

Your bot checks your machines, asks which folders each agent bot may use, creates the bots, and runs a small test so you can watch two of them work together.

## Rules the bots follow

- They work on a new `<botname>/...` branch. They never commit to main, push, merge or force-push.
- They only work in the folders you approve.
- They never send, post, deploy, or touch keys or `.env` files.
- They report back in plain words: what changed, tests, branch, and decisions left for you.

MIT licensed. Improvements welcome, especially headless commands for more agents.
