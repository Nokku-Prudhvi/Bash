### Which and Where is
    which showlog //shows full path how it is created
    alias showlog='tail -f /var/log/messages'

### wc,split,cat,diff commands:
    cat file1,file2  //cpncatenate files
    cat file* //concatenate all files having file in front

    wc file1 //number of lines in the files.New line count,word count,byte count
    cat file* |wc -l //total number of lines all of files together
    man wc  //man gives information about anything
    split -l 2 file2 //it creates seperate files containing 2 lines each from files2.
    rm x* //removes all files having x in front
    diff xaa xab //compares two files and shows the difference.

### Streams(stdin,stdout,stderr) and redirects:
    echo "new entry" >>filename //creates file with file name for any new entry if file doesn't exist.If file exists the command appens new-entry to 'filename' file.

    echo "new entry" > filename //This is done when we want to delete 'filename' file and start a fresh

    ls weoxyz 2>/dev/null  //to redirect standard-error to NULL(file in location)
    
    The > operator redirects the output usually to a file but it can be to a device. You can also use >> to append.
    If you don't specify a number then the standard output stream is assumed, but you can also redirect errors:
    > file redirects stdout to file
    1> file redirects stdout to file
    2> file redirects stderr to file
    &> file redirects stdout and stderr to file
    > file 2>&1 redirects stdout and stderr to file
    /dev/null is the null device it takes any input you want and throws it away. It can be used to suppress any output.
    Note that > file 2>&1 is an older syntax which still works, &> file is neater, but would not have worked on older systems.
    Example:
    $ fin /home/mobaxterm -name "github-keypar.pem" 2>delete.txt
    $ cat delete.txt
    bash: fin: command not found

    $fin /home/mobaxterm -name "github-keypar.pem" 1>delete.txt
    bash: fin: command not found
    $cat delete.txt
    $~           #(blank output)

    cat xab xac nofile > mystdoutput 2 > &1 //redirecing standard-error into same file mystdoutput

    set -o noclobber //which means where ever you use single-redirect(>) , no matter where u use it, u can't overwrite the file that already exist.
    set +o noclobber //sets above feature off

### pipes:
    ls /etc/ | grep cron      //finds all the cron items in /etc/ folder
    ls /etc |sort -f >sorted.txt   //sorts the content by ignoring case ('-f') [case-insensitive]

### grep,egrep(extended grep),fgrep:
    cat testf | grep hello  //dispay lines of hello in 'testf' file
    grep hello testf  //display lines of hello in 'testf' file
    grep hello testf  //same as above

    grep -c ^hello testf //gives count of all lines of hello starting with it('hello')
    grep hello$ testf //gives all lines those ends with hello
    grep ^[hpokhj] testf //gives all info of the lines starting with any of the letters
    grep [a-g] testf //gives all info of lines having letters a to g

    grep -lr cron /etc    //to searh all the files of the folder and return file names which have patern matching within the file
    $ cat two_cities.txt | grep "Sydney Carton\|Charles Darnay"|wc -l   //count the number of lines in the book that contain either the character 'Sydney Carton' or 'Charles Darnay'.

    egrep "hello.*world" testf //captures all the lines with hello world inside the file
    egrep -i "hello|world" testf //either hello or world . "-i" stands for ignore case.
    egrep -V 'hello|world' testf //return everything does not contains hello or world.

    fgrep hello$ testf //which give results contains exactly hello$ not anything else

### cut,sort,sed:
    cut -f1 -d: passwd //gets the first field element(f1 stands for that), in the password-file seperated by ':' delimitor(-d stands for that)

    cut -f2 -d/ passwd //we will get everything after '/' in passwd-dile

    cut -d, -f-4,6-6,8-10,12- passwd //if you wanted to skip 5, 7, and 11, you would use this

    sort|uniq -c //to get unique words we need to sort first. "-c" argument gives unique count.
    sort -n filename.txt //to sort file numerically
    sort -nr file1.txt   //numerical data in reverse order

    sort -t , -k3 -nr start_dir/second_dir/soccer_scores.csv // This will give the descending order of scores of csv file. This is basically sorting the third column(-k3 stands for selecting 3rd column) of the file using numerical-sort(-n stands for numerical sort) . "-t ," will be used if file is need to be seperated by delimeter (here it is comma)
    https://www.geeksforgeeks.org/sort-command-linuxunix-examples/


    sed 's/pattern/change/g' filename //where pattern is replaces with change but not actually changed.
    sed -i 's/pattern/change/g' filename //now pattern is replaced with change
    sed -i '/^$/d' textfile #To permanently remove empty lines from a file called textfile
    $ sed '/pattern/d' filename.txt
    Example:
    $ sed '/abc/d' filename.txt
    https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

########################################################

## Bash Script anatomy:
- A bash script usally begins with #!/usr/bash (on its own line)
  -  so your interpreter knows it is a bash script and to use Bash located in /usr/bash
  - This could be different path if you installed Bash somewhere else such as /bin/bash (type which bash to check)
- bash script has a file extension .sh
  - Techinically not needed this extension if first line has the she-bang and path to Bash(#!/usr/bash), but a convention
  
- Script can be run in terminal using `bash script_name.sh` Or if you have mentioned first line (#!/usr/bash) you can simply run using ./script_name.sh


### Bash Script Arguments:
The key concept of Bash scripting is arguments
Bash scripts can take arguments to be used inside by adding space after execution call

- ARGV is the array of all arguments given to program
- Each argument can be accessed via $ notation. The first as $1,second as $2 ,etc
- $@ and $* give all the arguents in ARGV
- $# gives lenght(number) of arguments

        bash args.sh one two three four five
        #!/usr/bash
        echo $1
        echo $2
        echo $@
        echo "There are " $# "arguments"
        output:
        one
        two
        one two three four five
        There are 5 arguments
        

### Meaning of $? (dollar question mark) in shell scripts
This is the exit status of the last executed command.

For example the command true always returns a status of 0 and false always returns a status of 1:

    true
    echo $? # echoes 0
    false
    echo $? # echoes 1

https://stackoverflow.com/questions/7248031/meaning-of-dollar-question-mark-in-shell-scripts


### What is indirect expansion? What does ${!var*} mean?
If the first character of parameter is an exclamation point (!), a level of variable indirection is introduced. Bash uses the value of the variable formed from the rest of parameter as the name of the variable; this variable is then expanded and that value is used in the rest of the substitution, rather than the value of parameter itself. This is known as indirect expansion.

    $ export xyzzy=plugh ; export plugh=cave

    $ echo ${xyzzy}  # normal, xyzzy to plugh
    plugh

    $ echo ${!xyzzy} # indirection, xyzzy to plugh to cave
    cave
    
https://stackoverflow.com/questions/8515411/what-is-indirect-expansion-what-does-var-mean

### What's the difference between $@ and $* [duplicate]
They aren't the same. $* is a single string, whereas $@ is an actual array. 
https://unix.stackexchange.com/questions/129072/whats-the-difference-between-and#:~:text=What's%20the%20difference%20between%20%24%40%20and%20%24*%20%5Bduplicate%5D&text=The%20%24%40%20holds%20list%20of,arguments%20passed%20to%20the%20script.&text=They%20appear%20to%20work%20the%20same%20in%20my%20scripts.


### exit-0-exit-1-and-exit-2-in-a-bash-script

    Exit code 0        Success
    Exit code 1        General errors, Miscellaneous errors, such as "divide by zero" and other impermissible operations
    Exit code 2        Misuse of shell builtins (according to Bash documentation)        Example: empty_function() {}

### How to read user input into a variable in Bash?

    # fullname="USER INPUT"
    read -p "Enter fullname: " fullname
    # user="USER INPUT"
    read -p "Enter user: " user
    If you like to confirm:

    read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
https://stackoverflow.com/questions/18544359/how-to-read-user-input-into-a-variable-in-bash

### What does 2>/dev/null mean?
The > operator redirects the output usually to a file but it can be to a device. You can also use >> to append.

If you don't specify a number then the standard output stream is assumed, but you can also redirect errors:

    > file redirects stdout to file
    1> file redirects stdout to file

    2> file redirects stderr to file

    &> file redirects stdout and stderr to file
    > file 2>&1 redirects stdout and stderr to file

    /dev/null is the null device it takes any input you want and throws it away. It can be used to suppress any output.

Note that > file 2>&1 is an older syntax which still works, &> file is neater, but would not have worked on older systems.

https://askubuntu.com/questions/350208/what-does-2-dev-null-mean



### AWK:
https://www.geeksforgeeks.org/awk-command-unixlinux-examples/

    awk options 'selection _criteria {action }' input-file > output-file
Options: 
-f program-file : Reads the AWK program source from the file 
                  program-file, instead of from the 
                  first command line argument.
-F fs            : Use fs for the input field separator

For each record i.e, line , the awk command splits the record delimeted by whitespace character by default and stores it in $n variables.

    $ awk '{print $1,$4}' employee.txt 
    ---
    ajay 45000
    sunil 25000


