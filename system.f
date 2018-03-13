\ Remember we're using fixed-point now!!!

\ assets
\  image -
\  sample - TBD when we add audio
\  map - statically compiled, reference object scripts which reference other assets so
\       they still need to be initialized at program start

\ other features
\  scripting
\


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
