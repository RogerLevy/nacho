
: loadmap  ( adr c -- nnn )
    dom if  dom-free  then
    bg clear  ppl clear
    loadnewtmx  swap to dom
;

: *fieldbg    bg one  /isotilemap ;

: load-farm
    " data/maps/farm1.tmx" loadmap to map
    map 0 loadtileset
    map 1 loadtileset
    map 2 loadbitmaps
    map 2 loadrecipes
    map " Tile Layer 1" layer  0 0 loadtilemap
    \ We load each named group individually but we could easily loop through all the groups;
    \ they are stored in the expected Z order.
    map " Plants and Buildings" objgroup loadobjects
    map " Shop Cactus" objgroup loadobjects
    map 0 @tilesetwh drop -2 /  0 at  *fieldbg
    0 0 at  *bean  me to p1
    ['] p1 is subject
;
