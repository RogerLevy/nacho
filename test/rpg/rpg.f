$000100 include ramen/brick
$10000 include ramen/tiled/tiled
$000100 include ramen/lib/stage
$000100 include nacho/test/rpg/sprites

stage 2000 pool: bg
stage 100 pool: ppl
stage 20 pool: misc

\ --------------------------------------------------------------------------------------------------

0 value p1  \ player1
: ?ctl  me p1 = ?exit r> drop ;

\ --------------------------------------------------------------------------------------------------

var ctr
var dir

action idle ( -- )
action walk ( -- )

\ --------------------------------------------------------------------------------------------------

: halt  vx 0v ;
: xaxis   0  <left> kstate if  drop -1 then  <right> kstate if  drop 1  then ;
: yaxis   0  <up> kstate if  drop -1  then  <down> kstate if  drop 1  then ;
: axes   xaxis yaxis ;
: clear  each> remove ;
: [role]  >in @  [section]  >in !  roledef ;

\ --------------------------------------------------------------------------------------------------
\ really simple collision detect provision

variable you
var reaction  ( other -- )
: with> me you ! r> reaction ! ;
: contact { me you @ as reaction @ ?call } ;

\ --------------------------------------------------------------------------------------------------
[section] objects

include nacho/test/rpg/chara