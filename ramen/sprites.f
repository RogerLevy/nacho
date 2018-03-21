$0000100 [version] sprites-ver

\ Sprite object tools!

\ Extend obj with the necessary transformation stuff
redef on
    var sx  var sy  var ang  var cx  var cy
    color sizeof field tint
redef off

\ right now sx and sy need to be initialized to 1,1 , and tint needs to be initialized to 1,1,1,1
\ this is just until we add prototypes to obj.f ...
: /sprite  1 1 sx 2!  1 1 1 1 tint 4! ;

\ Spritesheet - TBD
\ two kinds, one is auto-generated (tileset style) the other is user-defined

\ drawing a sprite from a spritesheet
\ : objsprite  ( spritesheet n flip -- )
\
\ ;

\ Drawing!
: objsubimage  ( image n flip -- )  \ uses image subdivision feature
    >r swap afsubimg
        tint 4@ 4af  cx 2@  at@  4af  sx 3@ 3af  r>  al_draw_tinted_scaled_rotated_bitmap_region ;


: objregion ( image rect flip )  \ pass a rectangle defining the region to draw
                                  \ origin of rotation is defined by the image
    locals| flip rect img |  bmp ?exit
    img image.bmp @  rect 4@ 4af  tint 4@ 4af  img image.orgx 2@ at@  4af  sx 3@ 3af  flip  al_draw_tinted_scaled_rotated_bitmap_region ;
