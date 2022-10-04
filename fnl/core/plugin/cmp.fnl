(module config.plugin.cmp
  {autoload {nvim aniseed.nvim}})

(let [(ok? cmp) (pcall require :cmp)]
  (when ok?
    (cmp.setup {:snippet {:expand (fn [args]
                                    ((. (require :luasnip) :lsp_expand) args.body))}
                :mapping {:<C-p> (cmp.mapping.select_prev_item)
                          
                          :<C-n> (cmp.mapping.select_next_item)
                        :<C-d> (cmp.mapping.scroll_docs (- 4))
                        :<C-f> (cmp.mapping.scroll_docs 4)
                        :<C-Space> (cmp.mapping.complete)
                        :<C-e> (cmp.mapping.close)
                        :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                    :select false})
                        :<Tab> (cmp.mapping (fn [fallback]
                                              (if (cmp.visible)
                                                  (cmp.select_next_item)
                                                  ((. (require :luasnip)
                                                      :expand_or_jumpable))
                                                  (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<Plug>luasnip-expand-or-jump
                                                                                                   true
                                                                                                   true
                                                                                                   true)
                                                                   "")
                                                  (fallback)))
                                            [:i :s])
                        :<S-Tab> (cmp.mapping (fn [fallback]
                                                (if (cmp.visible)
                                                    (cmp.select_prev_item)
                                                    ((. (require :luasnip)
                                                        :jumpable) (- 1))
                                                    (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<Plug>luasnip-jump-prev
                                                                                                     true
                                                                                                     true
                                                                                                     true)
                                                                     "")
                                                    (fallback)))
                                              [:i :s])}
                :sources [{:name :luasnip}
                          {:name :nvim_lsp}
                          {:name :buffer}
                          {:name :path}
                          {:name :conjure}]})))
