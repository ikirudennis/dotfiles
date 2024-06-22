-- don't fight the autoformat settings
vim.opt_local.formatoptions:remove({ "a" })

-- Enable spell check
vim.opt_local.spell = true

-- Enable dictionary autocomplete
vim.opt_local.complete:append({ "kspell" })

-- Wrap paragraphs at 72 characters
vim.opt_local.tw = 72

-- Add cursor column showing this 72 character width
vim.opt_local.cc = "+1"

-- in insert mode, use the `git jiraticket` command to insert the jira ticket
-- derived from the current branch name
vim.keymap.set("i", "<leader>j", "<C-R>=trim(system('git jiraticket'))<C-M> ")
