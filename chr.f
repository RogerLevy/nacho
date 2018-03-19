redef on
var ctr  var dir  var anmctr  var anm
redef off

: halt  vx 0v ;

: xaxis   0  <left> kstate if  drop -1 then  <right> kstate if  drop 1  then ;
: yaxis   0  <up> kstate if  drop -1  then  <down> kstate if  drop 1  then ;
: axes   xaxis yaxis ;

create walkdata
\ bits:  WENS
\ frame , flip ,
-1 , 0 ,     \
0 , 0 ,      \ south
8 , 0 ,      \ north
8 , 0 ,      \
4 , 0 ,      \ east
2 , 0 ,      \ southeast
6 , 0 ,      \ northeast
-1 , 0 ,     \
4 , 0 ,      \ west
2 , 0 ,      \ southwest
6 , 0 ,      \ northwest
-1 , 0 ,     \
-1 , 0 ,     \
-1 , 0 ,     \
-1 , 0 ,     \
-1 , 0 ,     \

: !dir
  0
  xaxis  dup 0< if  drop WEST or  else  0> if  EAST or  then  then
  yaxis  dup 0< if  drop NORTH or  else  0> if  SOUTH or  then  then
  dup 0 = if  SOUTH  or  then
  dir ! ;


action idle ( -- )
action walk ( -- )

: *chr  chrs one  draw>  32 32 rectf ;


\ --------------------------------------------------------------------------------------------------
[section] simplewalker
roledef simplewalker
: ?walk  axes 2dup vx 2!  or if  walk  then ;
: ?idle  axes or 0= if  idle  then ;
simplewalker :to walk ( -- )  !dir  1 anm !  act>  ?walk  ?idle ;
simplewalker :to idle ( -- )  anm off  halt  act>  ?walk ;


: ?1   ( -- 0/1 )  anmctr @  16 /  1 and ;
: anim>     ( data -- frame flip )  dir @ 2 * cells + 2@  ?1 u+  anm @ anmctr +! ;
\ : walk-spr  SPRSET_GUY walkdata anim> ;

: *simplewalker  *chr  simplerwalker become ;

\ guy start:
\   !dir  idle  show>  x 2v@ at  walk-spr DrawSpriteFlip ;
