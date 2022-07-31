syntax clear DirbufHash
syntax match DirbufHash /^#\x\{8}\t/ms=s-1 conceal cchar=#
setlocal conceallevel=3
setlocal concealcursor=n
setlocal nonumber
setlocal norelativenumber
