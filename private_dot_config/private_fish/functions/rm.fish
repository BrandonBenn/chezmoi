# Defined via `source`
function rm --wraps=trash --description 'alias rm=trash'
  trash $argv; 
end
