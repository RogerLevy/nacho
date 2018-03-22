\ --------------------------------------------------------------------------------------------------
\ basics

: !dir
    axes 2dup or if
        angle #1 +  45 /  dir !
    else  2drop  then  ;

: !vel   axes angle 2 vec vx 2! ;

: *chr  chrs one  draw>  32 32 rectf ;

\ --------------------------------------------------------------------------------------------------
[role] simplewalker

var anm  \ will be used differently from ANIMSPR

rolevar idledata
rolevar walkdata

simplewalker :to animate ( animdata speed -- )  anmspd !  anm !  0 ctr ! ;

: ?walk  axes or if  walk  then ;
: ?idle  axes or 0= if  idle  then ;

simplewalker :to walk ( -- )  !dir  my walkdata @  1 12 /  animate  act>  !dir  !vel  ?idle ;
simplewalker :to idle ( -- )  halt  my idledata @  1 12 /  animate  act>  ?walk ;

\ This isn't scalable ... if we "subclass" further things will happen out of order
: [finally]  postpone r>  ' >code ?lit " >r >r" evaluate ; immediate

: *simplewalker  ( image )
    *chr  /sprite  img !  simplewalker role !  [finally] idle
    draw>  anm @ dir @ 2 frames * +  2  animarray ;
