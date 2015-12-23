function Header_epi_insert()

  call inputsave()
  let s:projet =		input("Type project name : ", fnamemodify(getcwd(), ':t'))
  call inputrestore()

  let s:username = "bragag_m"
  "system("echo -n $USER")
  let s:fullname =	"Mathias Bragagia"
  "system("getent passwd \"" . s:username . "\" | cut -d ':' -f 5 | tr -d '\n'")

  let s:start =			"/*"
  let s:void =			"** "
  let s:line1 =			"** " . expand("%:t") . " for " . s:projet .  " in " . expand("%:p:h")
  let s:line2 =			"** Made by " . s:fullname
  let s:line3 =			"** Login   <" . s:username . "@epitech.net>"
  let s:line4 =			"** Started on  " . strftime("%a %b %e %H:%M:%S %Y") . " " . s:fullname
  let s:line5 = 		"** Last update " . strftime("%a %b %e %H:%M:%S %Y") . " " . s:fullname
  let s:end =				"*/"

  call append (0, s:start)
  call append (1, s:line1)
  call append (2, s:void)
  call append (3, s:line2)
  call append (4, s:line3)
  call append (5, s:void)
  call append (6, s:line4)
  call append (7, s:line5)
  call append (8, s:end)
  call append (9, "")

endfunction

function Header_epi_autoinsert()
	
endfunction

function s:update ()

  let s:pattern = "^** Last update .*$"
  let s:line = getline (8)

  if match (s:line, s:pattern) != -1
	  let s:username =	system("echo -n $USER")
	  let s:fullname = "Mathias Bragagia"
"system("getent passwd \"" . " s:username . "\" | cut -d ':' -f 5 | tr -d '\n'")
let s:modified = "** Last update " . strftime("%a %b %e %H:%M:%S %Y") . " " . s:fullname
call setline (8, s:modified)
  endif

endfunction

autocmd BufNewFile * call Header_epi_autoinsert ()
nnoremap <F10> :call Header_epi_insert()<cr>
autocmd BufWritePre * call s:update ()
