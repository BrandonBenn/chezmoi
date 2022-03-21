(local M {})

(λ M.for-each [proc list]
  "Apply {proc} to each element of {list}."
  (when (> (length list) 0)
    (each [_ item (pairs list)]
      (proc item))))

(λ M.for-each-pair [proc tbl]
  "Apply {proc} to each pair of {tbl}."
  (each [key value (pairs tbl)]
    (proc key value)))

M
