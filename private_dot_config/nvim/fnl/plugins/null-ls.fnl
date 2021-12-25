(let [null-ls (require :null-ls)]
  (null-ls.setup {:sources [null-ls.builtins.formatting.shfmt
                            null-ls.builtins.formatting.fnlfmt
                            null-ls.builtins.diagnostics.shellcheck]}))

