(let [coq (require :coq)]
  (coq.Now :--shut-up))

(let [coq_3p (require :coq_3p)]
  (coq_3p [{:src :repl :sh :bash :max_lines 99 :deadline 900}
           {:src :copilot :short_name :COP :accept_key :<c-f>}]))

