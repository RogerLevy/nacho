
: !dir
    axes 2dup or if
        angle #1 +  45 /  dir !
    else  2drop  then  ;

: !vel   axes angle 2 vec vx 2! ;

: *chr  chrs one  draw>  32 32 rectf ;

\ --------------------------------------------------------------------------------------------------
[section] simplewalker
roledef simplewalker

: ?walk  axes or if  walk  then ;
: ?idle  axes or 0= if  idle  then ;
simplewalker :to walk ( -- )  !dir  1 animate  act>  !dir  !vel  ?idle ;
simplewalker :to idle ( -- )  halt  0 animate  act>  ?walk ;

simplewalker :to >frame  ( animdata -- frame# flip )
    dir @ 4 cells * +
    anmctr @  12 /  1 and if  2 cells +  then  2@
    anmctr ++ ;

: *simplewalker  *chr  simplewalker become  idle ;
