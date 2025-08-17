(import-macros {: tx} :config.macros)

(tx :folke/which-key.nvim
    {:event :VeryLazy
     :config
     (fn []
       (let [wk (require :which-key)]
         (wk.add
          [(tx :<leader>p {:group "Project"})
           (tx :<leader>f {:group "File/Find"})
           (tx :<leader>b {:group "Buffers"})
           (tx :<leader>g {:group "Git"})
           (tx :<leader>h {:group "Help"})
           (tx :<leader>s {:group "Search"})])))})
