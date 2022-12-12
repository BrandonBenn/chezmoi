if exists("g:neovide")
  let g:neovide_scale_factor=1.0
  function! ChangeScaleFactor(delta)
    let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
  endfunction

  nnoremap <expr><C-=> ChangeScaleFactor(1.25)
  nnoremap <expr><C--> ChangeScaleFactor(1/1.25)
endif
