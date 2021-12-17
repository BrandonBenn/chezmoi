(let [null-ls (require :null-ls)]
  (null-ls.setup 
    { :sources 
     {1 null-ls.builtins.formatting.shfmt
      2 null-ls.builtins.diagnostics.shellcheck}}))
