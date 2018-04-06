\ : frames    1i /frame i* ;

\ Unnecessary.  We should instead have an animation data generator.

: animrange ( start len -- )  \ very simple frame animation; no flip support
    img @ 0= if  2drop  exit  then
    locals| len i |
    ctr @ len mod pfloor +to i
    img @
        rgntbl @ ?dup if
              i 1i /region i* +  0 fobjregion
        else  i 0 objsubimage  then
    anmspd @ ctr +!
    ctr @ len >= if  ctr @ len mod ctr !  animlooped  then
;


\ This is suboptimal; we should use regular animation data because
\   "frame tables" lock you in to a certain animation length.
\   An array of animation addresses is much better.
\   Anyway, having "one way of doing things" is simpler.

: animcycle  ( addr len -- )  \ simple animation on an array of frames
    img @ 0= if  2drop  exit  then
    2dup or 0= if  2drop  exit  then
    locals| len anm |
    ctr @ frames +to anm
    anm cell+ 2@ +at
    img @
        rgntbl @ ?dup if
              anm @ dup >r  1i /region i* +  r>  #3 and  fobjregion
        else  anm @ dup #3 and   objsubimage  then
    anmspd @ ctr +!
    ctr @ len >= if  ctr @ len mod ctr !  animlooped  then
;
