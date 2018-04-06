\ assets
\  image -
\  sample - TBD when we add audio
\  map - statically compiled, reference object scripts which reference other assets so
\       they still need to be initialized at program start

redef on
    var ctr
    var dir
redef off

action idle ( -- )
action walk ( -- )


: halt  vx 0v ;
: xaxis   0  <left> kstate if  drop -1 then  <right> kstate if  drop 1  then ;
: yaxis   0  <up> kstate if  drop -1  then  <down> kstate if  drop 1  then ;
: axes   xaxis yaxis ;


\ --------------------------------------------------------------------------------------------------
objlist stage
stage 50 pool: chrs

: clear  each>  remove ;
: scene  stage clear ;


\ --------------------------------------------------------------------------------------------------
\ really simple collision detect provision

variable you
var reaction  ( other -- )
: with> me you ! r> reaction ! ;
: contact { me you @ as reaction @ ?call } ;


\ --------------------------------------------------------------------------------------------------
\ loop
: render   chrs each> draw ;
: logic    chrs each> behave ;
: physics  chrs each> vx x v+ ;

\ --------------------------------------------------------------------------------------------------
[section] initsys

: initsys
    go>
    noop
;
initsys
