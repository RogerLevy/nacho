\ assets
\  image -
\  sample - TBD when we add audio
\  map - statically compiled, reference object scripts which reference other assets so
\       they still need to be initialized at program start

redef on
    var ctr
    var dir
    var anm       \ ID
    var anmctr
redef off

action idle ( -- )
action walk ( -- )
action >frame ( animdata -- frame# flip )
: animate  anmctr off  anm ! ;

: dirtable  create does> swap cells + @ ;

dirtable dir>ang  \ east , southeast , south , southwest , west , northwest , north , northeast ,
    0 , 45 , 90 , 135 , 180 , 225 , 270 , 315 ,

dirtable dir>rad  \ east , southeast , south , southwest , west , northwest , north , northeast ,
    0 , 45 >rad , 90 >rad , 135 >rad , 180 >rad , 225 >rad , 270 >rad , 315 >rad ,

: halt  vx 0v ;
: xaxis   0  <left> kstate if  drop -1 then  <right> kstate if  drop 1  then ;
: yaxis   0  <up> kstate if  drop -1  then  <down> kstate if  drop 1  then ;
: axes   xaxis yaxis ;


\ --------------------------------------------------------------------------------------------------
objlist stage
stage 50 pool chrs

: clear  each> en? -exit  remove ;
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
: physics  chrs each> en? -exit vx x v+ ;

\ --------------------------------------------------------------------------------------------------
[section] initsys

: initsys
    go>
    noop
;
initsys
