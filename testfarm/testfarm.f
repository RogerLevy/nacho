\ NOTES
\  I had to unrotate and flip some cactuses.
\  Justin: don't use rotate or scale or flip.
\  I changed folder structure, for now.  (you don't need to anymore though)
\  Justin: use all lower case from now on.

empty
$000100 include rpg/rpg

#2 to #globalscale
960 720 resolution

only forth definitions also xmling also tmxing
: deiso  at@  >car  at  ;
: ofs  wh@ 2 1 2/ 2negate +at  ;

:is tmxobj ( object-nnn XT -- )
    over ?type if cr type then  deiso  dup ofs  execute ;
:is tmxrect ( object-nnn w h -- )  cr 3. ;
:is tmximage ( object-nnn gid -- )
    deiso  swap ofs   bg one  gid !
    draw>  @gidbmp blit ;

\ ------------------------------------------------------------------------------------------------
\ Load map

" data/farm1.tmx" loadtmx  constant map  constant dom

map 0 loadtileset
map 1 loadtileset
map 2 loadbitmaps
map 2 loadrecipes
map " Tile Layer 1" layer  0 0 loadtilemap

\ ------------------------------------------------------------------------------------------------

#2 constant ALLEGRO_TTF_MONOCHROME
" data/fonts/Standard0765.ttf" 12 ALLEGRO_TTF_MONOCHROME font: font-menu
" data/bitmaps/Textbox.png" image: image-textbox

create dlgline 256 allot

: say  0 parse dlgline place ;
say I'm way too tired.

: /dialog
    draw>
    image-textbox >bmp blit
    font-menu >fnt font>  70 10 +at  at@  " Bean:" print  0 20 2+ at  dlgline count print ;


0 0 at  ui one /dialog

: *fieldbg    bg one  /isotilemap ;
*fieldbg  map 0 @tilesetwh drop -2 / x  !

\ We load each named group individually but we could easily loop through all the groups;
\ they are stored in the expected Z order.
map " Plants and Buildings" objgroup loadobjects
map " Shop Cactus" objgroup loadobjects

" data/objects/bean.f" findfile included
0 0 at *bean  ' p1 to subject


ok
