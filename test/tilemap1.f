\ NOTES
\  I had to unrotate and flip some cactuses.
\  Justin: don't use rotate or scale or flip.
\  I changed folder structure, for now.  (you don't need to anymore though)
\  Justin: use all lower case from now on.


empty
$000100 include ramen/brick
$10000 include ramen/tiled/tiled
$000100 include ramen/lib/stage

2 to global-scale  \ TODO: reconcile this GLOBAL-SCALE being treated as a fixedp by stage.f with the one used in UNMOUNT
stage 1000 pool: game


only forth definitions also xmling also tmxing
: deiso  at@  >car  at  ;
: ofs  wh@ 2 1 2/ 2negate +at  ;
:noname [ is tmxobj ] ( object-nnn XT -- )
    over ?type if cr type then  deiso  dup ofs  execute ;
:noname [ is tmxrect ] ( object-nnn w h -- )  cr 3. ;
:noname [ is tmximage ] ( object-nnn gid -- )
    deiso  swap ofs  game one  gid !
    draw>  @gidbmp blit ;


\ ------------------------------------------------------------------------------------------------
\ Load map

" nacho/test/tilemap1/farm1.tmx" loadtmx  constant map  constant dom

map 0 loadtileset
map 1 loadtileset
map 2 loadbitmaps
map 2 loadrecipes
map " Tile Layer 1" layer  0 0 loadtilemap


\ ------------------------------------------------------------------------------------------------
: left?  ( -- flag )  <left> kstate  <pad_4> kstate or  ; \ 0 0 joy x -0.25 <= or ;
: right?  ( -- flag ) <right> kstate  <pad_6> kstate or ; \ 0 0 joy x 0.25 >= or ;
: up?  ( -- flag )    <up> kstate  <pad_8> kstate or    ; \ 0 0 joy y -0.25 <= or ;
: down?  ( -- flag )  <down> kstate  <pad_2> kstate or  ; \ 0 0 joy y 0.25 >= or ;

: udlrvec  ( 2vec -- )
    >r
    0 0 r@ 2!
    left? if  -4 r@ x! then
    right? if  4 r@ x! then
    up? if    -4 r@ y! then
    down? if   4 r@ y! then
    r> drop ;

: *fieldbg    game one  /isotilemap ;
: *scroller   game one  me to cam  act>  player ?exit  vx udlrvec ;

*fieldbg  map 0 @tilesetwh drop -2 / x +!
*scroller

\ We load each named group individually but we could easily loop through all the groups;
\ they are stored in the expected Z order.
map " Plants and Buildings" objgroup loadobjects
map " Shop Cactus" objgroup loadobjects

\ 200 200 cam 's x 2!
go ok
