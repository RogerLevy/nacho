\ Remember we're using fixed-point now!!!
$000000 include ramen/opt/v2d
$000000 include ramen/opt/draw
include nacho/kb


\ assets
\  image -
\  sample - TBD when we add audio
\  map - statically compiled, reference object scripts which reference other assets so
\       they still need to be initialized at program start

\ other features
\  scripting
\


1
bit SOUTH
bit NORTH
bit EAST
bit WEST
drop


\ --------------------------------------------------------------------------------------------------
objlist stage
stage 100 pool chrs


\ --------------------------------------------------------------------------------------------------
[section] reaction

\ really simple collision detect provision
variable you
var reaction  ( other -- )
: with> me you ! r> reaction ! ;
: contact { me you @ as reaction @ ?call } ;

\ --------------------------------------------------------------------------------------------------
[section] Handler

: initsys
    go>
;

\ loop
: render   chrs each> draw ;
: logic    chrs each> behave ;
: physics  chrs each> enabled? -exit vx x v+ ;
