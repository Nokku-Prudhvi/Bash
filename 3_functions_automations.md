### Functions:

    function_name() {
      #func_code
      return #something
    }

You can also create a function like so:
The main differences:
Use the word function to denote starting a function build
You can drop the parenthesis on the opening line if you like, though many people keep them by convention

    function function_name {
      #func_code
      return #something
    }
    #######################
    function print_hello () {
      echo "Hello world!"
    }
    print_hello # here we call the function
    Hello world!
    #####################
    
    temp_f=30
    function convert_temp () {
    temp_c=$(echo "scale=2; ($temp_f - 32) * 5 / 9" | bc)
    echo $temp_c
    }
    convert_temp # call the function
    -1.11

### Passing arguments into Bash functions
You also have access to the special ARGV properties we previously covered:
Each argument can be accessed via the $1 , $2 notation.
$@ and $* give all the arguments in ARGV
$# gives the length (number) of arguments

### Scope in Bash functions
Unlike most programming languages (eg. Python and R), all variables in Bash are global by default.

    function print_filename {
      first_filename=$1
    }
    print_filename "LOTR.txt" "model.txt"
    echo $first_filename
    
    output:
    LOTR.txt

You can use the local keyword to restrict
variable scope.

    function print_filename {
      local first_filename=$1
    }
    print_filename "LOTR.txt" "model.txt"
    echo $first_filename
    output:
        #(blank)
        
### Return Values
The return option in Bash is only meant to determine if the function was a success (0) or
failure (other values 1-255). It is captured in the global variable $?
Our options are:
1. Assign to a global variable
2. echo what we want back (last line in function) and capture using shell-within-a-shell

        function function_2 {
        echlo # An error of 'echo'
        }
        function_2 # Call the function
        echo $? # Print the return value
        output:
        script.sh: line 2: echlo: command not found
        127  #this is the one returned by $?

### Scheduling with cron
You can see what schedules ( cronjobs ) are currently programmed using the following
command:

    crontab -l
    output:
    crontab: no crontab for user

[minute(0-59)] [hour(0-23)] [day of month(1-31)] [month(1-12)] [day of week(0-6)] command_to_execute

    5 1 * * * bash myscript.sh
Minutes star is 5 (5 minutes past the hour).
Hours star is 1 (a/er 1am). The last three are
* , so every day and month
Overall: run every day at 1:05am.

If you wanted to run something multiple times per day or every 'X' time increments, this is also
possible:
Use a comma for speci,c intervals. For example:
15,30,45 * * * * will run at the 15,30 and 45 minutes mark for whatever hours are
speci,ed by the second star. Here it is every hour, every day etc.
Use a slash for 'every X increment'. For example:
*/15 * * * * runs every 15 minutes. Also for every hour, day etc.
