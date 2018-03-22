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

var anmtbl
var anm  \ will be used differently from ANIMSPR

simplewalker :to animate ( index speed -- )  anmspd !  cells anmtbl @ + @ anm !  0 ctr ! ;

: ?walk  axes or if  walk  then ;
: ?idle  axes or 0= if  idle  then ;

simplewalker :to walk ( -- )  !dir  1  1 12 /  animate  act>  !dir  !vel  ?idle ;
simplewalker :to idle ( -- )  halt  0  1 12 /  animate  act>  ?walk ;

: *simplewalker  ( image animtable )
    *chr  /sprite  anmtbl !  img !  simplewalker become  idle
    draw>  anm @ dir @ 2 frames * +  2  animarray ;
