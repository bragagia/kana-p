" pyclewn run time file
" Maintainer:   <xdegaye at users dot sourceforge dot net>
"
" Configure VIM to be used with pyclewn and netbeans
"

" pyclewn version
let g:pyclewn_version = "pyclewn-1.9.py2"

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')
let g:pyclewn_home = s:plugin_path."/../"

" enable balloon_eval
if has("balloon_eval")
    set ballooneval
    set balloondelay=100
endif

" The 'Pyclewn' command starts pyclewn and vim netbeans interface.
command -nargs=* -complete=file Pyclewn call pyclewn#StartClewn(<f-args>)
