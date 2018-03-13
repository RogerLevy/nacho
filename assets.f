
variable mtime  \ last modified time
: loadbitmap  0 al_set_new_bitmap_flags    zstring al_load_bitmap ;
: art$  prjpath " /art.png" strjoin ;
: initgfx   art$ loadbitmap to art ;
: file>mtime  zstring al_create_fs_entry dup al_get_fs_entry_mtime swap al_destroy_fs_entry ;
: ?modified
    art$ file>mtime dup mtime @ <> if
        mtime !  r> drop
    exit then  drop ;
: updgfx   ?modified  art al_destroy_bitmap  art$ loadbitmap to art ;
