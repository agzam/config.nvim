(import-macros {: tx} :config.macros)

(fn smart-comment []
  (let [mode (vim.fn.mode)]
    (if (or (= mode :v) (= mode :V) (= mode ""))
        ;; Visual mode: comment selection
        (do
          (vim.api.nvim_feedkeys
            (vim.api.nvim_replace_termcodes :<Esc> true false true)
            :n false)
          ((. (require :Comment.api) :toggle :linewise) (vim.fn.visualmode)))
        ;; Normal mode: comment current line
        ((. (require :Comment.api) :toggle :linewise :current)))))

(tx
 :numToStr/Comment.nvim
 {:event :VeryLazy
  :opts {}
  :config
  (fn []
    (let [cmt (require :Comment)]
      (cmt.setup {:mappings
                  {:basic false
                   :extra false}})))
  :init
  (fn []
    (let [defaults {:noremap true}
          keys [[:n "<leader>;" smart-comment {:desc "Comment"}]]]
      (each [_ [m k cmd opts] (pairs keys)]
        (vim.keymap.set
         m k cmd
         (vim.tbl_extend :force defaults opts)))))})
