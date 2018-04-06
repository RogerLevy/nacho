empty

$000100 include ramen/ramen.f

: ending ( addr len char -- addr len )
   >r begin  2dup r@ scan
      ?dup while  2swap 2drop  #1 /string
   repeat  r> 2drop ;

[defined] linux [if]
: -filename ( a n -- a n )  2dup  [char] / ending  nip - ;
[else]
: -filename ( a n -- a n )  2dup  [char] \ ending  nip - ;
[then]


: strconst:  create string, does> count ;

including -filename cr 2dup type strconst: prjpath

[defined] source-id [if]  source-id close-file  drop [then]

prjpath " main.f" strjoin included