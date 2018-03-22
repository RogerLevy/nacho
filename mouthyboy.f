create walkdata
    1   frame,  0   frame,   \ e
    1   frame,  0   frame,   \ se
    4   frame,  3   frame,   \ s
    1 [h] frame,  0  [h] frame,  \ sw
    1 [h] frame,  0  [h] frame,  \ w
    1 [h] frame,  0  [h] frame,  \ nw
    2 [h] frame,  2    frame,   \ n
    1   frame,  0    frame,   \ ne

create idledata
    0  frame,   0  frame,
    5  frame,   5  frame,
    5  frame,   5  frame,
    5  frame,   5  frame,
    0  [h] frame,   0  [h] frame,
    0  [h] frame,   0  [h] frame,
    6  frame,   6  frame,
    0  frame,   0  frame,

create animtable  idledata , walkdata ,

" nacho/data/mouthyboy.png" asset image-mouthyboy
64 64 image-mouthyboy subdivideimage

: *mouthyboy  image-mouthyboy animtable *simplewalker ;
