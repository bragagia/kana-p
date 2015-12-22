setlocal tabstop=8
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal cindent
setlocal cinoptions={1s,>2s,e-1s,^-1s,n-1s,:1s,p5,i4,(0,u0,W1s
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%80v.\+/
highlight UnwantSpace ctermbg=red ctermfg=white
2match UnwantSpace /\s\+\%#\@<!$/
