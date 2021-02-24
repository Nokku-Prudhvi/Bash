### Basic If statement

    if [ CONDITION ]; then
      #SOME CODE
    else
      #SOem code
    fi

-Spaces between square brackets and conditional elements inside(first line)
-Semi colon after close-bracket ];
 
 
    x="Queen"
    if [ $x == "King" ]; then
    echo "$x is a King!"
    else
    echo "$x is not a King!"
    fi
    Queen is not a King!


### Arthimetic IF
Arithmetic IF statements can use the double-parenthesis structure:

    x=10
    if (($x>5)); then
      echo "$x is more than 5!"
    fi
    output: 10 is more than 5!
    
Arithmetic IF statements can also use square brackets and an arithmetic flag rather than ( > ,< , = , != etc.):

    x=10
    if [ $x -gt 5 ]; then
      echo "$x is more than 5!"
    fi
    10 is more than 5!
    
 Other Bash conditional flags
Bash also comes with a variety of file-related .ags such as:

    -e if the file exists
    -s if the file exists and has size greater than zero
    -r if the file exists and is readable
    -w if the file exists and is writable
    


### And or 
In Bash you can either chain conditionals as follows:

    x=10
    if [ $x -gt 5 ] && [ $x -lt 11 ]; then
      echo "$x is more than 5 and less than 11!"
    fi
Or use double-square-bracket notation:

    x=10
    if [[ $x -gt 5 && $x -lt 11 ]]; then
    echo "$x is more than 5 and less than 11!"
    fi


### IF and command-line programs
You can also use many command-line programs directly in the conditional, removing the
square brackets.
For example, if the ,le words.txt has 'Hello World!' inside:

    if grep -q Hello words.txt; then
    echo "Hello is inside!"
    fi
    Hello is inside!

Or you can call a shell-within-a-shell as well for your conditional.

    if $(grep -q Hello words.txt); then
    echo "Hello is inside!"
    fi
    Hello is inside!   
    
 
### FOR loop in bash

    for x in 1 2 3
    do 
        echo $x
    done

    output:
    1
    2
    3
    #################
    for x in {1..5..2}
    do
        echo $x
    done
    1
    3
    5

Another common way to write FOR loops is the 'three expression' syntax.

    for ((x=2;x<=4;x+=2))
    do
           echo $x
    done
    2
    4

Bash also allows pattern-matching expansions into a for loop using the * symbol such as files in a directory.

    for book in books/*
    do
        echo $book
    done
    
    for book in $(ls books/ | grep -i 'air')
    do
        echo $book
    done
    
### While
Similar to a FOR loop. Except you set a condition which is tested at each iteration.
Iterations continue until this is no longer met!
Use the word while instead of for
Surround the condition in square brackets
Use of same .ags for numerical comparison from IF statements (such as -le )
Multiple conditions can be chained or use double-brackets just like 'IF' statements along with && (AND) or || (OR)
Ensure there is a change inside the code that will trigger a stop 

    x=1
    while [ $x -le 3 ];
    do
        echo $x
        ((x+=1))
    done
    1
    2
    3

### CASE
Case statements can be more optimal than IF statements when you have multiple or complex conditionals.

    case 'STRING' in 
    PATTERN1) 
    COMMAND1;; 
    PATTERN2) 
    COMMAND2;;
    *) 
    DEFAULT COMMAND;;
    esac
    
    ##########
    if grep -q 'sydney' $1; then
        mv $1 sydney/
    fi
    if grep -q 'melbourne|brisbane' $1; then
        rm $1
    fi
    if grep -q 'canberra' $1; then
        mv $1 "IMPORTANT_$1"
    fi
    ##############
    
    case $(cat $1) in
        *sydney*)
        mv $1 sydney/ ;;
        *melbourne*|*brisbane)
        rm $1 ;;
        *canberra*)
        mv $1 "IMPORTANT_$1" ;;
        *)
        echo "No citi found" ;;
     esac
    


