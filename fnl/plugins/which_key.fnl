(import-macros {: tx} :config.macros)

(tx :folke/which-key.nvim
    {:event :VeryLazy
     :config
     (fn []
       (let [which-key (require :which-key)]
         (which-key.add
          [(tx :<leader>b {:group "Buffers"})
           (tx :<leader>f {:group "File/Find"})
           (tx :<leader>g {:group "Git"})
           (tx :<leader>h {:group "Help"})
           (tx :<leader>j {:group "Jump"})
           (tx :<leader>p {:group "Project"})
           (tx :<leader>s {:group "Search"})
           (tx :<leader>w {:group "Windows"})])))})
