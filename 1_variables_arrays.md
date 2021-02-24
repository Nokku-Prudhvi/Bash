### Assigining variables
    similar to other languages, you can assign with equal notation
    var1="moom"

    Referenced via:
    echo $var1
    output: moom

    Bash is not forgiving about spaces in variable creation
    var1 = "Moon"
    echo $var1 
    Ouput: Error:Line3:var1: command not found

### Single, double, backticks
    In Bash, using different quotation marks can mean different things. Both when creating
    variables and printing.
    Single quotes ( 'sometext' ) = Shell interprets what is between literally
    Double quotes ( "sometext" ) = Shell interprets literally except using $ and backticks
    The last way creates a 'shell-within-a-shell', outlined below. Useful for calling command-line
    programs. This is done with backticks.
    Backticks (`sometext`) = Shell runs the command and captures STDOUT back into a variable

Let's see the effect of different types of variable creation
    now_var='NOW'
    now_var_singlequote='$now_var'
    echo $now_var_singlequote
    $now_var
    
    now_var_doublequote="$now_var"
    echo $now_var_doublequote
    NOW

### Shell within a shell:
    rightnow_doublequote="The date is `date`."
    echo $rightnow_doublequote
The date is Mon 2 Dec 2019 14:13:35 AEDT.
The date program was called, output captured and combined in-line with the echo call.
We used a shell within a shell!

### Parentheses vs backticks
    rightnow_doublequote="The date is `date`."
    rightnow_parentheses="The date is $(date)."
    echo $rightnow_doublequote
    echo $rightnow_parentheses
The date is Mon 2 Dec 2019 14:54:34 AEDT.
The date is Mon 2 Dec 2019 14:54:34 AEDT.


### Numerical variables
Numbers are not built in natively to the shell like most REPLs(console) such as R and python

expr is useful utility program (just like cat or grep)
 
    expr 1+4
    5
 but expr utility also not support decimal numbers, so for the decimal numbers we can use bc(basic calculator) command-line program
 
    echo "5+7.5" |bc
    output:12.5

    echo "10/3"|bc
    output : 3
    
using scale via bc we can get decimal-places output
    
    echo "scale=3;10/3"|bc
    output : 3.33
    
 Double bracket notation
 
    expr 5 + 7
    echo $((5 + 7))
    12
    12
    
 
 ## Arrays:
 
 - Normal numerical-indexed structure called a 'list' in Python or 'vector' in R
 
 - Declare without adding elements:
 
        declare -a my_first_Array
 - Create and add elements at same time
 
        my_first_array=(1 2 3)
 - Remember - no spaces around equals sign!
 - Commas are not used to separate array elements in Bash.
 
 ### Properties of Array:
 - All array elements can be returned using array[@] . Though do note, Bash requires curly
brackets around the array name when you want to access these properties.

    my_array=(1 3 5 2)
    echo ${my_array[@]}  //similar to terraform refernece of teeraform-11 version
    
- length of array:

        echo ${#my_array[@]}
 
### Manipulating array elements:
Remember: Bash uses zero-indexing for arrays like Python (but unlike R!)

    my_first_array=(15 20 300 42)
    echo ${my_array[2]}
    output: 300
    
    my_first_array[0]=999
    echo ${my_first_array[0]}
    output: 999
- Remember: don't use the $ when overwriting an index such as $my_first_array[0]=999 ,
as this will not work.

- Use the notation array[@]:N:M to 'slice' out a subset of the array.
Here N is the starting index and M is how many elements to return.

    my_first_array=(15 20 300 42 23 2 4 33 54 67 66)
    echo ${my_first_array[@]:3:2}
    ouput: 42 23
    
### Appending to arrays:
Append to an array using array+=(elements) .

    my_array=(300 42 23 2 4 33 54 67 66)
    my_array+=(10)
    echo ${my_array[@]}
    output: 300 42 23 2 4 33 54 67 66 10
    

## Associative arrays(dictionaries):
Similar to a normal array, but with key-value pairs, not numerical indexes
Similar to Python's dictionary or R's list
Note: This is only available in Bash 4 onwards. Some modern macs have old Bash! Check
with bash --version in terminal

    declare -A city_details #Declare first
    city_details=([city_name]="New York" [population]=140000) #Add eleemnts
    echo ${city_details[city_name]} #Index using key to return a value
    output:New York
    
    #create an associative array and assign in one line
    declare -A city_details=([city_name]="New York" [population]=14000000)
    echo ${!city_details[@]} #Return all keys
    output: city_name population
    
