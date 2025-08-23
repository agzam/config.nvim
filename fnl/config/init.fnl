(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

;; don't wrap lines
(set vim.wo.wrap false)

;; space is reserved to be lead
(vim.keymap.set :n :<space> :<nop> {:noremap true})

;; sets a nvim global options
(let [options
      {;; tabs is space
       :expandtab true
       ;; tab/indent size
       :tabstop 2
       :shiftwidth 2
       :softtabstop 2
       ;; settings needed for compe autocompletion
       :completeopt "menuone,noselect"
       ;; case insensitive search
       :ignorecase true
       ;; smart search case
       :smartcase true
       ;; shared clipboard
       :clipboard "unnamedplus"
       ;; show line numbers
       :number true
       ;; show line and column number
       :ruler true
       ;; makes signcolumn always one column with signs and linenumber
       :signcolumn "number"
       :timeoutlen 250
       }]
  (each [option value (pairs options)]
    (core.assoc vim.o option value)))

(set vim.g.clipboard "osc52")

(let [defaults {:noremap true}
      keys [[:t :<Esc> :<C-\><C-n> {:desc "Exit terminal mode"}
             ;; :t "<localleader>," :<C-\><C-n> {:desc "Exit terminal mode"}
             ;; C-c C-c like in Emacs Indirect buffers
             :n :<c-c><c-c> :<cmd>wq<cr> {}
             :n :<c-c><c-k> :<cmd>qa!<cr> {}]]]
  (each [_ [m k cmd opts] (pairs keys)]
    (vim.keymap.set
     m k cmd
     (vim.tbl_extend :force defaults opts))))

;; (require :config.macros)
(require :config.kitty)

{}
