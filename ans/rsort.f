\ custom radix sort! (limited range)
\ supports sorting a range of fixed-point or integer numbers: 0 ~ 65535, inclusive.
\ if there's no fixed point support loaded, you can sort integers.

\ Theory:
\  the "radix" in a radix sort is a position of a digit within each number
\  we're sorting.  with each pass, we move the radix one digit.
\  we "bucket" each number based on the radix.  do this on enough radixes and you magically
\  get sorted numbers.
\  we start at the right and move to the left until we've sorted the most significant
\  digit.
\  a radix sort involves no comparisons, but requires a large amount of memory.
\  to control memory use we limit the range of values that this routine
\  can recognize.
\  for this routine to require just 4 passes, we do it by nybbles,
\  which requires 16 buckets * 2.  each bucket needs to be big enough for the
\  entire array, otherwise we'd need extra passes to figure out how big each one
\  needs to be and there'd be more code and we have tons of RAM.
\  since this is meant to be used for game objects, a reasonable maximum limit is
\  8192 items which works out to 1MB.  but you could sort other things that have a
\  concept of "priority"...
\  $0fff f000 <--- these is a bitmask showing the bits we sort.
\  You can use the XT passed to RSORT to sort other numbers or even structs, you just
\  have to transform them into the expected datatype.
\ --------------------------------------------------------------------------------------------------

decimal

vocabulary rsorting  only forth also rsorting definitions
    0 value src
    0 value dest
    : src!  to src ;
    : dest!  to dest ;

    [undefined] 1i [if] \ support for without fixed point loaded
        : 1i ;
        $0000000f constant nyb0
        0 constant pass1shift
    [else]
        $0000f000 constant nyb0
        12 constant pass1shift
    [then]

    [undefined] @+ [if]  : @+  dup cell + swap @ ;  [then]

    nyb0 value radix
    pass1shift value radixShift
    15 constant bucketShift
    8192 constant #max  \ actual max is #MAX - 1, one cell is reserved for bucket count
    defer @key  ( item -- key )
    create table0  #max cells 16 * allot
    create table1  #max cells 16 * allot
    table0 value table

    [undefined] >> [if] : >> rshift ; : << lshift ; [then]
    : bounds  over + swap ;

    : other  table table0 = if  table1  else  table0  then  to table ;
    : radix++  radix 4 << to radix  4 +to radixShift ;
    : bucket  ( bucket# -- bucket )  bucketShift <<  table + ;
    : +bucket  ( n bucket# -- )  bucket 1 over +! dup @ cells + ! ;
    : /buckets  ( -- )  16 0 do  0 i bucket !  loop ;

    : irpass  ( first-item count -- )
      cells bounds ?do  i @ dup @key  radix and  radixShift >>  +bucket  cell +loop ;

    : tablepass  ( -- )
      other /buckets  16 0 do  other i bucket @+ other irpass  loop  radix++ ;

    : irinit  ( xt -- )
      is @key
      pass1shift to radixShift  nyb0 to radix
      table0 to table  /buckets  other  /buckets  other ;

    : !result  ( -- )
      16 0 do  i bucket @+ cells dup >r  dest swap move  r> +to dest  loop ;

previous definitions also rsorting
: rsort  ( addr #cells xt -- )  \ destructive, XT is @KEY  ( addr -- key )
    over 0= if 2drop drop exit then
    swap 1i swap
    irinit  over src!  irpass  radix++
    tablepass tablepass tablepass
    src dest!  !result
; 

\ --------------------------------------------------------------------------------------------------
marker dispose
[undefined] .0 [if] : .0 ;  [then]
: , .0 , ;

create sortable
    4123 , 9 , 5 , 1 , 401 , 234 , 100 , 5 , 99 , 4123 , 23 , 3 , 400 , 50 , 500 , 999 ,
: test  [defined] .0 [if] .0 [then]  <> abort" radix sort test failed!" ;
sortable 16 cells hex idump decimal
sortable 16 .0 ' noop rsort
cr sortable 16 cells hex idump decimal
sortable
    @+ 1 test
    @+ 3 test
    @+ 5 test
    @+ 5 test
    @+ 9 test
    @+ 23 test
    @+ 50 test
    @+ 99 test
    @+ 100 test
    @+ 234 test
    @+ 400 test
    @+ 401 test
    @+ 500 test
    @+ 999 test
    @+ 4123 test
    @+ 4123 test
drop
cr .( :::RSORT TESTS PASSED:::)
dispose
