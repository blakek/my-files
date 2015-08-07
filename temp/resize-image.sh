#!/bin/bash

if [[ "$#" -lt "2" ]]; then
    printf 'Usage:\n%s new_geometry  file ...
    new_geometry:  the new geometry of the file in the format width[xheight]
                   (e.g. height is optional).\n' "$(basename $0)"

    exit 1
fi

# Notice that -resize is expecting our first arg... All others should be file names
mogrify -filter lanczos2 -format jpg -quality 90 -resize "$@"