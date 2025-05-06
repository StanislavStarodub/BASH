#!/usr/bin/env bash

function DICE()
{

declare NUM=$(($RANDOM % 6 + 1))
            
case $NUM in
    1)
       echo "┌───────┐"
       echo "│       │"
       echo "│   o   │"
       echo "│       │"
       echo "└───────┘"
       ;;
    2)
       echo "┌───────┐"
       echo "│ o     │"
       echo "│       │"
       echo "│     o │"
       echo "└───────┘"
       ;;
                                                                                                                                                                                  3)
       echo "┌───────┐"
       echo "│ o     │"
       echo "│   o   │"
       echo "│     o │"
       echo "└───────┘"
       ;;
     4)
       echo "┌───────┐"
       echo "│ o   o │"
       echo "│       │"
       echo "│ o   o │"
       echo "└───────┘"
       ;;
     5)
       echo "┌───────┐"
       echo "│ o   o │"
       echo "│   o   │"
       echo "│ o   o │"
       echo "└───────┘"
       ;;
     6)
       echo "┌───────┐"
       echo "│ o   o │"
       echo "│ o   o │"
       echo "│ o   o │"
       echo "└───────┘"
       ;;
esac
    echo "Your number of dice is: $NUM"
}
