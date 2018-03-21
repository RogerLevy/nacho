create walkdata
    1 , 0 ,   0 , 0 ,   \ e
    1 , 0 ,   0 , 0 ,   \ se
    4 , 0 ,   3 , 0 ,   \ s
    1 , #1 ,  0 , #1 ,  \ sw
    1 , #1 ,  0 , #1 ,  \ w
    1 , #1 ,  0 , #1 ,  \ nw
    2 , #1 ,  2 , 0 ,   \ n
    1 , 0 ,   0 , 0 ,   \ ne

create idledata
    0 , 0 ,   0 , 0 ,
    5 , 0 ,   5 , 0 ,
    5 , 0 ,   5 , 0 ,
    5 , 0 ,   5 , 0 ,
    0 , #1 ,  0 , #1 ,
    0 , #1 ,  0 , #1 ,
    6 , 0 ,   6 , 0 ,
    0 , 0 ,   0 , 0 ,

create anms  idledata , walkdata ,
: anm>  anm @ cells anms + @ ;

" nacho/data/mouthyboy.png" asset image-mouthyboy
64 64 image-mouthyboy subdivideimage
: *mouthyboy  *simplewalker  /sprite
    draw>  image-mouthyboy  anm> >frame objsubimage ;
