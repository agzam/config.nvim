(import-macros {: tx} :config.macros)

(tx
 :smoka7/hop.nvim
 {:event :VeryLazy
  :opts {}
  :init
  (fn []
    (let [defaults {:noremap true}
          keys [[:n :<leader>jj ":HopPattern <CR>" {:desc "Goto sequence"}]]]
      (each [_ [m k cmd opts] (pairs keys)]
        (vim.keymap.set
         m k cmd
         (vim.tbl_extend :force defaults opts)))))})
