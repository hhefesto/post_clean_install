#!/bin/bash

for dir in ./*/
do
    dir=${dir%*/}

    cd ${dir##*/}
    echo "Git dir that is going to be pushed to Github:"
    echo ${dir##*/}
    git add .
    git commit -m "commit previous to fedora update"
    git pull

    /usr/bin/expect <(cat <<EOF
set timeout -1
spawn git push
expect "Username for 'https://github.com':"
send "hhefesto\r"
expect "Password for 'https://hhefesto@github.com':"
send "facilderecordar789\r"
interact
EOF
)
    echo "Push finished"
    cd ..
done

