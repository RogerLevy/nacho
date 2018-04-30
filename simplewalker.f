\ --------------------------------------------------------------------------------------------------
[role] simplewalker

\ animation tables
rolevar idledata
rolevar walkdata

: !dir
    axes 2dup or if
        angle #1 +  45 /  dir !
    else  2drop  then  ;

: !vel   axes angle 2.5 vec vx 2! ;

: ?walk  axes or if  walk  then ;
: ?idle  axes or 0= if  idle  then ;

: ?changedir
    dir @  !dir  dir @  <> if  walk  r> drop  !vel  then ;

simplewalker :to walk ( -- )
    !dir  img @  my walkdata @ dir @ [] @  animate  1 9 / anmspd !
    act>  ?changedir  !vel  ?idle ;

simplewalker :to idle ( -- )
    halt  img @  my idledata @ dir @ [] @  animate  1 9 / anmspd !
    act>  ?walk ;

: /simplewalker  ( role image )  img !  role !  /scalerot  idle  draw>  animspr ;
