(let [null-ls (require :null-ls)]
  (null-ls.setup {:sources [null-ls.builtins.diagnostics.eslint_d
                            null-ls.builtins.diagnostics.proselint
                            null-ls.builtins.diagnostics.shellcheck
                            null-ls.builtins.formatting.shfmt
                            null-ls.builtins.formatting.fnlfmt
                            null-ls.builtins.formatting.eslint_d
                            (null-ls.builtins.formatting.prettier.with [:html
                                                                        :json
                                                                        :markdown])]}))

