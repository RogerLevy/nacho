#2 to #globalscale
960 720 resolution

\ Variables ===================================================
0 value map  \ xml node
0 value dom  \ current map dom



\ MAP STUFF ===================================================
only forth definitions also xmling also tmxing
: deiso  at@  >car  at  ;
: ofs  wh@ 2 1 2/ 2negate +at  ;

:is tmxobj ( object-nnn XT -- )
    over ?type if cr type then  deiso  dup ofs  execute ;
:is tmxrect ( object-nnn w h -- )  cr 3. ;
:is tmximage ( object-nnn gid -- )
    deiso  swap ofs   bg one  gid !
    draw>  @gidbmp blit ;


\ DIALOG ======================================================
#2 constant ALLEGRO_TTF_MONOCHROME
" data/fonts/Standard0765.ttf" 12 ALLEGRO_TTF_MONOCHROME font: font-menu
" data/images/Textbox.png" image: image-textbox

create dlgline 256 allot

: /dialog
    draw>
    image-textbox >bmp blit
    font-menu >fnt font>  70 10 +at  at@  " Bean:" print  0 20 2+ at  dlgline count print ;

0 0 at  ui one /dialog

: say  0 parse dlgline place  ;
say I'm way too tired.

\ Temporary:
\ BEAN ========================================================
" data/objects/bean.f" findfile included
