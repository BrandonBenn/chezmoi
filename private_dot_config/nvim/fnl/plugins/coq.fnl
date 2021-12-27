(let [coq_3p (require :coq_3p)]
  (coq_3p [{:src :repl :sh :bash :max_lines 99 :deadline 900}
           {:src :copilot :short_name :COP :tmp_accept_key :<c-r>}]))

