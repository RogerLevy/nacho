$000100 include ramen/ramen.f

: ending ( addr len char -- addr len )
   >r begin  2dup r@ scan
      ?dup while  2swap 2drop  #1 /string
   repeat  r> 2drop ;
[defined] linux [if]
: -name ( a n -- a n )  2dup  [char] / ending  nip -  #1 -  0 max ;
[else]
: -name ( a n -- a n )  2dup  [char] \ ending  nip -  #1 -  0 max ;
[then]
: strconst  create string, does> count ;

including 2dup type -name strconst prjpath
: rld  prjpath " /main.f" strjoin included ;

[defined] source-id [if]  source-id close-file  drop [then]
rld
