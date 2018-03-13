include ramen/opt/v2d
$10000 include ramen/opt/draw
include nacho/system

[section] Main
create player object
: start
\    initgfx
    initsys
    show>
        tan backdrop
        hold>
            player as x 2@ at  art drawbitmap
    step>
        player as vx x v+
;

\ --------------------------------------------------------------------------------------------------
[section] Init
[defined] source-id [if]  source-id close-file  drop [then]
start ok
