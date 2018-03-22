$0000100 [version] sprites-ver

\ Sprite objects!
\ - Render subimages or image regions
\ - Define animation data and animate sprites

redef on
    \ Transformation info; will be factored out eventually
    var sx  var sy  var ang  var cx  var cy
    color sizeof field tint
    \ Animation state
    var img  var rgntbl  var anm  var ctr  var anmspd
redef off

\ right now sx and sy need to be initialized to 1,1 , and tint needs to be initialized to 1,1,1,1
\ this is just until we add prototypes to obj.f ...
: /sprite  1 1 sx 2!  1 1 1 1 tint 4! ;

\ --------------------------------------------------------------------------------------------------
\ Drawing!
: objsubimage  ( image n flip -- )  \ uses image subdivision feature
    >r swap afsubimg
        tint 4@ 4af  cx 2@ at@  4af  sx 3@ 3af  r>  al_draw_tinted_scaled_rotated_bitmap_region ;


: objregion ( image rect flip )  \ pass a rectangle defining the region to draw
    locals| flip rect img |  bmp ?exit
    img image.bmp @  rect 4@ 4af  tint 4@ 4af  cx 2@ at@  4af  sx 3@ 3af  flip  al_draw_tinted_scaled_rotated_bitmap_region ;


: fobjregion ( image frect flip )  \ like OBJREGION but the rectangle is in floats
    locals| flip rect img |  bmp ?exit
    img image.bmp @  rect 4@  tint 4@ 4af  cx 2@ at@  4af  sx 3@ 3af  flip  al_draw_tinted_scaled_rotated_bitmap_region ;


\ --------------------------------------------------------------------------------------------------
\ Define region tables.  We pre-convert the rect part to floats for speed

: region,  ( x y w h )  4af 4,  0 , 0 , ;
: <origin  ( x y )  2negate  here 2 cells - 2! ;
6 cells constant /region

\ --------------------------------------------------------------------------------------------------
\ Define animations

: anim:  ( image regiontable|0 speed -- loopaddr )  ( -- )  \ when defined word is called, animation plays
    create 3,  0 0 at  here
    does>  @+ img !  @+ rgntbl !  @+ anmspd !  anm !  0 ctr ! ;
: frame,  ( index+flip -- )  , 0 , 0 , ;
: <ofs    ( x y )  here 2 cells - 2! ;
: frames,  0 do dup frame, loop drop ;
: [h]  #1 or ;
: [v]  #2 or ;
: animloop:  drop here ;
: ;anim  ( loopaddr -- )  here  $deadbeef , - , ;
3 cells constant /frame
: frames    1i /frame i* ;

\ --------------------------------------------------------------------------------------------------
\ Integration

action animlooped ( -- )

: animspr  ( -- )
    anm @ -exit  img @ -exit
    anm @ cell+ 2@ +at
    img @
        rgntbl @ ?dup if
              anm @ @ dup >r  1i /region i* +  r>  #3 and  fobjregion
        else  anm @ @ dup #3 and   objsubimage  then
    anmspd @ ctr +!
    begin  ctr @ 1 >= while
        ctr --  /frame anm +!
        anm @ @ $deadbeef = if  anm @ cell+ @ anm +!  animlooped  then
    repeat
;

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

: animarray  ( addr len -- )  \ simple animation on an array of frames
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
