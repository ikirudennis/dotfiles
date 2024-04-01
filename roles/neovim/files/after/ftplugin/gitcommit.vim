setlocal formatoptions-=a

" Enable spell check
setlocal spell

" Enable dictionary autocomplete
setlocal complete+=kspell

" Wrap paragraphs at 72 characters
setlocal tw=72

" Add cursor column showing this 72 character width
setlocal cc=+1

" in insert mode, use the `git jiraticket` command to insert the jira ticket
" derived from the current branch name
inoremap <leader>j <C-R>=trim(system('git jiraticket'))<C-M> 