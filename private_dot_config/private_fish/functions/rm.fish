# Defined via `source`
function rm --wraps=trash --wraps='gio trash' --description 'alias rm trash'
  trash $argv; 
end
