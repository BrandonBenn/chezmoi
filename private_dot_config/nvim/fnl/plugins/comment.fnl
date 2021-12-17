(local {: map! : set! } (require :utils))
(let [Comment (require :Comment)]
  ((. Comment :setup) {}))
