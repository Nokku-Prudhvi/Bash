### Extracting scores with shell
$ sort -t , -k3 -nr start_dir/second_dir/soccer_scores.csv // This will give the descending order of scores of csv file. This is basically sorting the third column(-k3 stands for selecting 3rd column) of the file using numerical-sort(-n stands for numerical sort) . "-t ," will be used if file is need to be seperated by delimeter (here it is comma)


### Searching a book with shell
There is a copy of Charles Dickens's infamous 'Tale of Two Cities' in your home directory called two_cities.txt.

Use command line arguments such as cat, grep and wc with the right flag to counShell pipelines to Bash scriptst the number of lines in the book that contain either the character 'Sydney Carton' or 'Charles Darnay'. Use exactly these spellings and capitalizations.

$ cat two_cities.txt | grep "Sydney Carton\|Charles Darnay"|wc -l
77
$ cat two_cities.txt | egrep "Sydney Carton|Charles Darnay"|wc -l
77


### A simple Bash script
There is a file in your working directory called server_log_with_todays_date.txt. Your task is to write a simple Bash script that concatenates this out to the terminal so you can see what is inside.
      #!/bin/bash
      # Concatenate the file
      cat server_log_with_todays_date.txt

### Shell pipelines to Bash scripts:
In this exercise, you are working as a sports analyst for a Bulgarian soccer league. You have received some data on the results of the grand final from 1932 in a csv file. The file is comma-delimited in the format Year,Winner,Winner Goals which lists the year of the match, the team that won and how many goals the winning team scored, such as 1932,Arda,4.

Your job is to create a Bash script from a shell piped command which will aggregate to see how many times each team has won.
Don't worry about the tail -n +2 part, this just ensures we don't aggregate the CSV headers!

    #!/bin/bash

    # Create a single-line pipe
    cat soccer_scores.csv | cut -d "," -f 2 | tail -n +2 | sort | uniq -c

### Extract and edit using Bash scripts:
 you need to do some editing on the data you have. Several teams have changed their names so you need to do some replacements. The data is the same as the previous exercise.
 
    #!/bin/bash
    # Create a sed pipe to a new file
    echo `cat soccer_scores.csv | sed 's/Cherno/Cherno City/g' | sed 's/Arda/Arda United/g' ` >> soccer_scores_edited.csv

    #!/bin/bash

    # Create a sed pipe to a new file
    cat soccer_scores.csv | sed 's/Cherno/Cherno City/g' | sed 's/Arda/Arda United/g' > soccer_scores_edited.csv
    
### Using arguments with HR data    
You need to extract salary figures for recent hires, however, the HR IT system simply spits out hundreds of files into the folder /hire_data.

Each file is comma-delimited in the format COUNTRY,CITY,JOBTITLE,SALARY such as Estonia,Tallinn,Javascript Developer,118286

Your job is to create a Bash script to extract the information needed. 

      # Echo the first ARGV argument
      echo $1 

      # Cat all the files
      # Then pipe to grep using the first ARGV argument
      # Then write out to a named csv using the first ARGV argument
      cat hire_data/* | grep "$1" > "$1".csv
      
  
