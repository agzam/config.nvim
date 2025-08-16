(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(fn kitty-buffer-history-clean []
  "Clean the shit up for scrollback pager in Kitty."
  (vim.fn.setreg "/" "") ; clear search register
  (vim.api.nvim_command "cnoremap q q!") ; map q to force quit
  (each [k v (pairs {:modifiable true
                     :confirm false
                     :number true})]
    (core.assoc vim.o k v))
  (each [_ pattern
         (pairs
          ["silent! %s/]133;.*\\%u5c//g"                  ; OSC 133 sequences
           "silent! %s/\\e\\[[0-9:;]*m//g"                ; ANSI color codes
           "silent! %s/[^[:alnum:][:punct:][:space:]]//g" ; non-printable chars
           "silent! %s/\\e\\[[^\\s]*\\s//g"               ; other escape sequences
           "silent! %s/\\s*$//"                           ; trailing whitespace
           ])]
    (pcall vim.cmd pattern)))

(vim.api.nvim_create_user_command
 :KittyBufferHistoryClean
 kitty-buffer-history-clean
 {})

{: kitty-buffer-history-clean}
