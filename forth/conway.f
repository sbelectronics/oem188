\ https://rosettacode.org/wiki/Conway%27s_Game_of_Life#Forth
\ The fast wrapping requires dimensions that are powers of 2.
64 constant w
16 constant h
 
 : rows    w * 2* ;
 1 rows constant row
 h rows constant size
 
 create world size allot

 variable old
 world old !
 variable new
 old @ w + new !
 
 \ world   value old
 \ old w + value new
 
 variable gens
 : clear  world size erase     0 gens ! ;
 \ : age  new old to new to old  1 gens +! ;
 : age new @ old @ new ! old ! 1 gens +! ;
 
 : col+  1+ ;
 : col-  1- dup w and + ; \ avoid borrow into row
 : row+  row + ;
 : row-  row - ;
 : wrap ( i -- i ) [ size w - 1- ] literal and ;
 : w@ ( i -- 0/1 ) wrap old @ + c@ ;
 : w! ( 0/1 i -- ) wrap old @ + c! ;
 
 : foreachrow ( xt -- )
   size 0 do  I over execute  row +loop drop ;
 
 : showrow ( i -- ) cr
   old @ + w over + swap do I c@ if 42 else bl then emit loop ;
 : show  ['] showrow foreachrow  cr ." Generation " gens @ . ;
 
 : sum-neighbors ( i -- i n )
   dup  col- row- w@
   over      row- w@ +
   over col+ row- w@ +
   over col-      w@ +
   over col+      w@ +
   over col- row+ w@ +
   over      row+ w@ +
   over col+ row+ w@ + ;
 : gencell ( i -- )
   sum-neighbors  over old @ + c@
   or 3 = 1 and   swap new @ + c! ;
 : genrow ( i -- )
   w over + swap do I gencell loop ;
 : gen ['] genrow foreachrow age ;

 : cls 27 emit ." [2J" ;
 : home 27 emit ." [0;0H" ;
 
 : life cls begin gen home show key? until ;

 : blinker 
   dup 1 swap w! 
   col+ dup 1 swap w! 
   col+ dup 1 swap w! ;

: glider
   col+ dup 1 swap w!
   row+ col-
   col+ col+ dup 1 swap w!
   row+ col- col-
   dup 1 swap w!
   col+ dup 1 swap w!
   col+ dup 1 swap w!
   ;

 clear  0 glider life