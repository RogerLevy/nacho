[section] top

#2 to #globalscale
960 720 resolution

\ Variables ===================================================
0 value map  \ xml node
0 value dom  \ current map dom

create dlgline 256 allot

\ MAP STUFF ===================================================
[section] map
only forth definitions also xmling also tmxing
: deiso  at@  >car  at  ;
: ofs  wh@ 2 1 2/ 2negate +at  ;

:is tmxobj ( object-nnn XT -- )
    over ?type if cr type then  deiso  dup ofs  execute ;
:is tmxrect ( object-nnn w h -- )  cr 3. ;
:is tmximage ( object-nnn gid -- )
    deiso  swap ofs   bg one  gid !
    draw>  @gidbmp blit ;


\ ==============================================================
[section] dialog
#2 constant ALLEGRO_TTF_MONOCHROME
" data/fonts/Standard0765.ttf" 12 ALLEGRO_TTF_MONOCHROME font: font-menu
" data/images/Textbox.png" image: image-textbox


: act-dialog
    act>  ?focus
    <z> kpressed if  me remove  pop-focus  then ;

: *dialog
    ui one  me push-focus  act-dialog
    draw>
    image-textbox >bmp blit
    font-menu >fnt font>  70 10 +at  at@  " Bean:" print  0 20 2+ at  dlgline count print ;


: say  ( adr c -- ) dlgline place  0 0 at *dialog ;




\ Temporary:
\ ==============================================================
[section] bean
" data/objects/bean.f" findfile included
