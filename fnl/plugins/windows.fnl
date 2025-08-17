(import-macros {: tx} :config.macros)

(tx
 :declancm/maximize.nvim
 {:init
  (fn []
    (let [maximize (require :maximize)
          defaults {:noremap true}
          keys [[:n :<leader>wm maximize.toggle {:desc "Maximize"}]
                [:n :<leader>ww ":wincmd w<CR>" {:desc "Other"}]
                [:n :<leader>wh ":wincmd h<CR>" {:desc "Left"}]
                [:n :<leader>wj ":wincmd j<CR>" {:desc "Down"}]
                [:n :<leader>wk ":wincmd k<CR>" {:desc "Up"}]
                [:n :<leader>wl ":wincmd l<CR>" {:desc "Right"}]

                [:n :<leader>wH ":wincmd H<CR>" {:desc "Move Left"}]
                [:n :<leader>wJ ":wincmd J<CR>" {:desc "Move Down"}]
                [:n :<leader>wK ":wincmd K<CR>" {:desc "Move Up"}]
                [:n :<leader>wL ":wincmd L<CR>" {:desc "Move Right"}]

                [:n :<leader>ws ":wincmd s<CR>" {:desc "Split"}]
                [:n :<leader>wS ":split | wincmd w<CR>" {:desc "Split-n-follow"}]

                [:n :<leader>wv ":wincmd v<CR>" {:desc "VSplit"}]
                [:n :<leader>wV ":vsplit | wincmd w<CR>" {:desc "VSplit-n-follow"}]

                [:n :<leader>wd ":wincmd q<CR>" {:desc "Delete"}]

                [:n :<leader>bd ":bdelete <CR>" {:desc "Delete"}]
                [:n :<leader>bn ":bnext <CR>" {:desc "Next"}]
                [:n :<leader>bp ":bprevious <CR>" {:desc "Previous"}]

                [:n :<leader>fs ":write <CR>" {:desc "Save"}]]]
     (each [_ [m k cmd opts] (pairs keys)]
       (vim.keymap.set
        m k cmd
        (vim.tbl_extend :force defaults opts)))))})
