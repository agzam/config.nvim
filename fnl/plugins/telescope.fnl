(import-macros {: tx} :config.macros)

(tx :nvim-telescope/telescope.nvim
    {:dependencies [:nvim-lua/plenary.nvim
                    :debugloop/telescope-undo.nvim
                    :nvim-telescope/telescope-file-browser.nvim
                    (tx :nvim-telescope/telescope-fzf-native.nvim
                        {:build "make"})]
     :config
     (fn []
       (let [telescope (require :telescope)
             actions (require :telescope.actions)
             options {:extensions {:undo {}}
                      :defaults
                      {:vimgrep_arguments
                       ["rg" "--color=never" "--no-heading"
                        "--with-filename" "--line-number" "--column"
                        "--smart-case" "--hidden" "--glob=!.git/"]

                       :mappings
                       {:i {:<esc> actions.close
                            :<C-c> #(vim.cmd :stopinsert)
                            :kj #(vim.cmd :stopinsert)}
                        :n {:q actions.close}}}}
             extensions [:fzf
                         :undo
                         :file_browser]]
         (each [_ ext (pairs extensions)]
           (telescope.load_extension ext))
         (telescope.setup options)))

     :cmd :Telescope
     :init
     (fn []
       (let [bi (require :telescope.builtin)
             fb (. (require :telescope) :extensions :file_browser :file_browser)
             def {:noremap true}
             keys [[:n :<leader>pf bi.find_files {:desc "Find in cwd"}]
                   [:n :<leader>ff #(fb {:hidden true}) {:desc "File browser"}]
                   [:n :<leader>bb bi.buffers {:desc "Buffers"}]
                   [:n :<leader>/ bi.live_grep {:desc "Live Grep"}]
                   [:n :<leader>hh bi.help_tags {:desc "Apropos"}]
                   [:n :<leader>ss bi.current_buffer_fuzzy_find {:desc "Lines"}]]]
         (each [_ [m k cmd opts] (pairs keys)]
           (vim.keymap.set
            m k cmd
            (vim.tbl_extend :force def opts)))))})

