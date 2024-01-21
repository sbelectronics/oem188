: writeloop dup sp@ 32 - here do dup I c! 1+ loop drop ;
: readloop dup sp@ 32 - here do dup 255 and I c@ 
  <> if I u. I c@ U. cr then 1+ loop drop ;
: memtest1 writeloop readloop drop ;
: memtest 255 0 do cr ." pass " I U. I memtest1 loop ;
