# ClaudeBot + CodexBot for Grok Bot

Two Grok Bot teammates that drive the coding agents you already use:

- **ClaudeBot** runs [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and uses your Claude Pro or Max plan.
- **CodexBot** runs [Codex](https://github.com/openai/codex) and uses your ChatGPT Plus or Pro plan.

They work **on your own computers, in your local project folders**. Your code doesn't need to be on GitHub. Your main Grok Bot, or a Chief of Staff bot, assigns tasks. The coding bots create a branch, run the tool, can ask each other for a review, and check in after every task. Nothing is pushed, merged or posted without your OK.

It's a human-in-the-loop setup: you approve, the agents do the work.

## Use it

1. Install the Grok Bot desktop app on each computer that holds code, and sign in.
2. Install Claude Code and Codex there and sign in to each.
3. Paste [SETUP_PROMPT.md](SETUP_PROMPT.md), everything below its line, into your main Grok Bot chat.

Your bot checks your machines, asks which folders each coding bot may use, creates both bots, and runs a small test so you can see them work together.

## Rules the bots follow

- They work on a new `claudebot/...` or `codexbot/...` branch. They never commit to main, push, merge or force-push.
- They only work in the folders you approve.
- They never send, post, deploy, or touch keys or `.env` files.
- They report back in plain words: what changed, tests, branch, and decisions left for you.

MIT licensed. Improvements welcome.
