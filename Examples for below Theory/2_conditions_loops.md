### Sorting model results
You are working as a data scientist in a large corporation. The production environment for your machine learning models writes out text files into the model_results/ folder whenever an experiment is completed. The files have the following structure (example):

Model Name: KNN
Accuracy: 89
F1: 0.87
Date: 2019-12-01
ModelID: 34598utjfddfgdg
You can see the model name, accuracy and F1 scores, the date the experiment completed and a unique ID to link the model experiment back into your experiment system.

The company has a threshold of 90% for accuracy for a model to continue experimentation. Your task is to write a Bash script that takes in an ARGV argument (a filename), extracts the accuracy score and conditionally sorts the model result file into one of two folders: good_models/ for those with accuracy greater than or equal to 90 and bad_models/ for those less than 90. You must run your script from the terminal with the requested arguments before submitting your answer.

    # Extract Accuracy from first ARGV element
    accuracy=$(grep Accuracy $1 | sed 's/.* //')

    # Conditionally move into good_models folder
    if [ $accuracy -ge 90 ]; then
        mv $1 good_models/
    fi

    # Conditionally move into bad_models folder
    if [ $accuracy -lt 90 ]; then
        mv $1 bad_models/
    fi


### Moving relevant files
You have recently joined a new startup as one of the few technical employees. Your manager has asked if you can assist to clean up some of the folders on the server. The company has been through a variety of server monitoring software and so there are many files that should be deleted.

Luckily you know that all the files to keep contain both vpt and SRVM_ inside the file somewhere.

Your task is to write a Bash script that will take in file names as ARGV elements and move the file to good_logs/ if it matches both conditions above. Remember from the lecture, the q flag is for 'quiet' so it doesn't return the matched lines like grep normally does. It just returns true if any lines match.

Remember that when you use command-line arguments like grep in IF statements, there is no need for square brackets so don't add them! You must also remember to run your script using each file as an ARGV element. One each time; a total of four times to run your script.

    # Create variable from first ARGV element
    sfile=$1

    # Create an IF statement on sfile's contents
    if grep -q 'SRVM_' $sfile && grep -q 'vpt' $sfile; then
      # Move file if matched
      mv $sfile good_logs/
    fi
 
 
### A simple FOR loop

You are working as a data scientist in an organization. Due to a recent merge of departments, you have inherited a folder with many files inside. You know that the .R scripts may be useful for your work but you aren't sure what they contain.

Write a simple Bash script to loop through all the files in the directory inherited_folder/ that end in .R and print out their names so you can get a quick look at what sort of scripts you have. Hopefully the file names are useful!

    # Use a FOR loop on files in directory
    for file in inherited_folder/*.R
    do  
        # Echo out each file
        echo $file
    done

### Cleaning up a directory

 Unfortunately, when team members logins were terminated, all their files were dumped into a single folder.

The good news is that most of their useful code has been backed up. However, all their python files using the Random Forest algorithm are buried in the file dump.

The task has fallen to you to sift through the hundreds of files to determine if they are both Python files and contain a Random Forest model. This sounds like a perfect opportunity to use your Bash skills, rather than checking every single file manually.

Write a script that loops through each file in the robs_files/ directory to see if it is a Python file (ends in .py) AND contains RandomForestClassifier. If so, move it into the to_keep/ directory.

    # Create a FOR statement on files in directory
    for file in robs_files/*.py
    do  
        # Create IF statement using grep
        if grep -q 'RandomForestClassifier' $file; then
        #____ grep -____ '____' $file ; ____
            # Move wanted files to to_keep/ folder
            mv $file to_keep/
        fi
    done

### Days of the week with CASE
In your role as a Data Scientist, it is sometimes useful to associate dates with a 'working day' (Monday, Tuesday, Wednesday, Thursday, Friday) or a 'weekend' (Saturday & Sunday).

Your task is to build a small Bash script that will be useful to call in many areas of your data pipeline. It must take in a single argument (string of a day) into ARGV and use a CASE statement to print out whether the argument was a weekday or a weekend.


    # Create a CASE statement matching the first ARGV element
    case $1 in
      # Match on all weekdays
      "Monday"|"Tuesday"|"Wednesday"|"Thursday"|"Friday")
      echo "It is a Weekday!";;
      # Match on all weekend days
      Saturday|Sunday)
      echo "It is a Weekend!";;
      # Create a default
      *) 
      echo "Not a day!";;
    esac
    
 ### Moving model results with CASE
 You are working as a data scientist in charge of analyzing some machine learning model results. The production environment moves files into a folder called model_out/ and names them model_RXX.csv where XX is a random number related to which experiment was run.

Each file has the following structure (example):

Model Name, Accuracy, CV, Model Duration (s)
Logistic,42,4,48
Your manager has told you that recent work in the organization has meant that tree-based models are to be kept in one folder and everything else deleted.

Your task is to use a CASE statement to move the tree-based models (Random Forest, GBM, and XGBoost) to the tree_models/ folder, and delete all other models (KNN and Logistic).

    # Use a FOR loop for each file in 'model_out/'
    for file in model_out/*
    do
        # Create a CASE statement for each file's contents
        case $(cat $file) in
          # Match on tree and non-tree models
          *"Random Forest"*|*GBM*|*XGBoost*)
          mv $file tree_models/ ;;
          *KNN*|*Logistic*)
          rm $file ;;
          # Create a default
          *) 
          echo "Unknown model in $file" ;;
        esac
    done






