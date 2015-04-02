# ASP integration for Vim

ASP is lacking any sort of functional IDE, besides maybe the Emacs-integration that comes with SWI and Sicstus. Vim has traditionally not been a good editor for ASP. In fact, it is close to being nothing more than a plain text editor for ASP.

These files seek to change this. Copy them into your `$VIM_RUNTIME` or just `~/.vim`, preserving the directory structure.
Or, with Vundle or NeoBundle : 

    NeoBundle 'Aluriak/ASP.vim'

The files are public domain, and a total copy with some modifications of prolog.vim.

## Feature Highlights

- Accounts for pretty much all of ASP syntax (including DCGs)
- Syntactical hints for folding
- Accounts for the full set of ISO built-in predicates and operators
- Also features the full set of SWI built-ins.
- gorgeous fruit-salad-fu for your ASP
