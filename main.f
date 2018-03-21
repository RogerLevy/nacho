$000100 include ramen/lib/v2d.f
$000100 include ramen/lib/draw.f
$000100 include nacho/afk/kb.f
$000100 include nacho/ramen/sprites.f
$000100 include nacho/ramen/gameutils.f
$000100 include nacho/ramen/scripting.f
include nacho/system.f
include nacho/chr.f
include nacho/mouthyboy.f

\ --------------------------------------------------------------------------------------------------
[section] Main

*mouthyboy named player

: newgame
    player as
        viewwh 2halve x 2!
;

: start
\    initgfx
    initsys
    newgame
    show>
        tan backdrop
        render
    step>
        physics
        \ other physics
        poll
        logic
;

\ --------------------------------------------------------------------------------------------------
[section] Init

[defined] source-id [if]  source-id close-file  drop [then]

start \ ok
