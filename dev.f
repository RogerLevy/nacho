empty

$000100 include ramen/ramen.f


: strconst:  create string, does> count ;

including -filename cr 2dup type strconst: prjpath

[defined] source-id [if]  source-id close-file  drop [then]

prjpath " main.f" strjoin included