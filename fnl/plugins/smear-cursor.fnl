(import-macros {: tx} :config.macros)

(tx
 :sphamba/smear-cursor.nvim
 {:event :VeryLazy
  :opts {:smear_insert_mode false}
  :init
  (fn []
    (let [smear-cursor (require :smear_cursor)]
      (set smear-cursor.enabled true)))})
