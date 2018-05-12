empty

$000100 include ramen/ramen.f


: strconst:  create string, does> count ;

including -filename cr 2dup type strconst: prjpath

prjpath " main.f" strjoin included