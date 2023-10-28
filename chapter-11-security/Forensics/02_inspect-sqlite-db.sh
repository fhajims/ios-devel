#!/bin/sh

fn="MapTiles.sqlitedb"

mkdir -p tmp

# sqlite3 -help

# sqlite3
# sqlite> .help

echo ".tables" | sqlite3 


# sqlite> 
#         select * from version;
#         select * from images;
sqlite3 "${fn}" ".schema images" 
sqlite3 MapTiles.sqlitedb "select * from images limit 7;"

# write blob to file
sqlite3 MapTiles.sqlitedb "SELECT writefile('tmp/image-data-id-3.jpg', data) FROM images limit 1"
