# NeoVim Key Bindings

This file contains a list of all the key bindings for this neovim configuration.

## General

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `<leader>+` | Increment number |
| `<leader>-` | Decrement number |

## Window Management

| Key | Action |
|---|---|
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>sm` | Maximize/minimize a split |

## Tab Management

| Key | Action |
|---|---|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tf` | Open current buffer in new tab |

## File Explorer (NvimTree)

| Key | Action |
|---|---|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Toggle file explorer on current file |
| `<leader>ec` | Collapse file explorer |
| `<leader>er` | Refresh file explorer |

## Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Fuzzy find files in cwd |
| `<leader>fr` | Fuzzy find recent files |
| `<leader>fs` | Find string in cwd |
| `<leader>fc` | Find string under cursor in cwd |
| `<leader>ft` | Find todos |

## Git (Gitsigns)

| Key | Action |
|---|---|
| `]h` | Next Hunk |
| `[h` | Prev Hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hB` | Toggle line blame |
| `<leader>hd` | Diff this |
| `<leader>hD` | Diff this ~ |
| `ih` | Gitsigns select hunk |

## Lazygit

| Key | Action |
|---|---|
| `<leader>lg` | Open lazy git |

## Debugging (DAP)

| Key | Action |
|---|---|
| `<leader>dt` | Toggle Breakpoint |
| `<leader>dc` | Continue |
| `<leader>dn` | Step Over |
| `<leader>di` | Step Into |
| `<leader>do` | Step Out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run Last |
| `<leader>du` | Toggle DAP UI |

## Trouble

| Key | Action |
|---|---|
| `<leader>xw` | Open trouble workspace diagnostics |
| `<leader>xd` | Open trouble document diagnostics |
| `<leader>xq` | Open trouble quickfix list |
| `<leader>xl` | Open trouble location list |
| `<leader>xt` | Open todos in trouble |

## Substitute

| Key | Action |
|---|---|
| `s` | Substitute with motion |
| `ss` | Substitute line |
| `S` | Substitute to end of line |
| `s` (visual) | Substitute in visual mode |

## TODO Comments

| Key | Action |
|---|---|
| `]t` | Next todo comment |
| `[t` | Previous todo comment |

## Treesitter Text Objects

| Key | Action |
|---|---|
| `a=` | Select outer part of an assignment |
| `i=` | Select inner part of an assignment |
| `l=` | Select left hand side of an assignment |
| `r=` | Select right hand side of an assignment |
| `a:` | Select outer part of an object property |
| `i:` | Select inner part of an object property |
| `l:` | Select left part of an object property |
| `r:` | Select right part of an object property |
| `aa` | Select outer part of a parameter/argument |
| `ia` | Select inner part of a parameter/argument |
| `ai` | Select outer part of a conditional |
| `ii` | Select inner part of a conditional |
| `al` | Select outer part of a loop |
| `il` | Select inner part of a loop |
| `af` | Select outer part of a function call |
| `if` | Select inner part of a function call |
| `am` | Select outer part of a method/function definition |
| `im` | Select inner part of a method/function definition |
| `ac` | Select outer part of a class |
| `ic` | Select inner part of a class |
| `<leader>na` | swap parameters/argument with next |
| `<leader>n:` | swap object property with next |
| `<leader>nm` | swap function with next |
| `<leader>pa` | swap parameters/argument with prev |
| `<leader>p:` | swap object property with prev |
| `<leader>pm` | swap function with previous |
| `]f` | Next function call start |
| `]m` | Next method/function def start |
| `]c` | Next class start |
| `]i` | Next conditional start |
| `]l` | Next loop start |
| `]s` | Next scope |
| `]z` | Next fold |
| `]F` | Next function call end |
| `]M` | Next method/function def end |
| `]C` | Next class end |
| `]I` | Next conditional end |
| `]L` | Next loop end |
| `[f` | Prev function call start |
| `[m` | Prev method/function def start |
| `[c` | Prev class start |
| `[i` | Prev conditional start |
| `[l` | Prev loop start |
| `[F` | Prev function call end |
| `[M` | Prev method/function def end |
| `[C` | Prev class end |
| `[I` | Prev conditional end |
| `[L` | Prev loop end |
| `;` | repeat last move |
| `,` | repeat last move opposite |
| `f` | builtin f |
| `F` | builtin F |
| `t` | builtin t |
| `T` | builtin T |

## Session Management

| Key | Action |
|---|---|
| `<leader>wr` | Restore session for cwd |
| `<leader>ws` | Save session for auto session root dir |

## Formatting

| Key | Action |
|---|---|
| `<leader>mp` | Format file or range (in visual mode) |

## Linting

| Key | Action |
|---|---|
| `<leader>l` | Trigger linting for current file |