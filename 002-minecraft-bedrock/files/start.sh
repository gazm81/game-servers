#!/bin/sh
/usr/bin/tmux new-session -s minecraft -d
tmux send -t minecraft "LD_LIBRARY_PATH=. ./bedrock_server" ENTER
tmux send -t minecraft "gamerule showcoordinates true" ENTER
tmux send -t minecraft "gamerule keepInventory true" ENTER
