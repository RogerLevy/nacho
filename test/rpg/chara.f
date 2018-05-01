\ --------------------------------------------------------------------------------------------------
[role] chara

\ animation tables
rolevar idledata
rolevar walkdata

: !dir
    axes 2dup or if
        angle #1 +  45 /  dir !
    else  2drop  then  ;

: !vel   axes angle 2 vec vx 2! ;

: ?walk  axes or if  walk  then ;
: ?idle  axes or 0= if  idle  then ;

: ?changedir
    dir @  !dir  dir @  <> if  walk  r> drop  !vel  then ;

chara :to walk ( -- )
    !dir  img @  my walkdata @ dir @ [] @  animate  1 9 / anmspd !
    act>  ?ctl  ?changedir  !vel  ?idle ;

chara :to idle ( -- )
    halt  img @  my idledata @ dir @ [] @  animate  1 9 / anmspd !
    act>  ?ctl  ?walk ;

: /chara  ( role image )  img !  role !  /scalerot  idle  draw>  ( frame@ -0.5 -0.75 2*  +at  2drop )  animspr ;
