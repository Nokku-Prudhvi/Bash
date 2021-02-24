### variable

    # Create the required variable
    yourname="Sam"

    # Print out the assigned name (Help fix this error!)
    echo "Hi there $yourname, welcome to the website!"


### Numerical Variables:

Your task is to write a program that takes in a single number (a temperature in Fahrenheit) as an ARGV argument, converts it to Celsius and returns the new value

    # Get first ARGV into variable
    temp_f=$1

    # Subtract 32
    temp_f2=$(echo "scale=2; $temp_f - 32" | bc)

    # Multiply by 5/9 and print
    temp_c=$(echo "scale=2; $temp_f2 * 5 / 9" | bc)

    # Print the celsius temp
    echo $temp_c


    ########################
    # Get first ARGV into variable
    temp_f=$1

    temp_b=`echo "scale=2; (($temp_f-32)*5)/9"|bc`
    echo $temp_b
    
 ### Arrays
In this exercise, you will firstly build an array using two different methods and then access the length of the array. You will then return the entire array using a different special property.

    # Create a normal array with the mentioned elements
    capital_cities=("Sydney" "New York" "Paris")

    # Create a normal array with the mentioned elements using the declare method
    declare -a capital_cities

    # Add (append) the elements
    capital_cities+=("Sydney")
    capital_cities+=("New York")
    capital_cities+=("Paris")

    # The array has been created for you
    capital_cities=("Sydney" "New York" "Paris")

    # Print out the entire array
    echo ${capital_cities[@]}

    # Print out the array length
    echo ${#capital_cities[@]}


In this exercise we will practice creating and adding to an associative array. We will then access some special properties that are unique to associative arrays. Let's get started!

    # Create empty associative array
    declare -A model_metrics

    # Add the key-value pairs
    model_metrics["model_accuracy"]=98
    model_metrics["model_name"]="knn"
    model_metrics["model_f1"]=0.82

    # Declare associative array with key-value pairs on one line
    declare -A model_metrics=([model_accuracy]=98 [model_name]="knn" [model_f1]=0.82)

    # Print out the entire array
    echo ${model_metrics[@]}

    # An associative array has been created for you
    declare -A model_metrics=([model_accuracy]=98 [model_name]="knn" [model_f1]=0.82)

    # Print out just the keys
    echo ${!model_metrics[@]}
    
### Climate calculations in Bash
You are continuing your work as a data scientist for the climate research organization. In a previous exercise, you extracted temperature data for 3 regions you are monitoring from some files from the /temps directory.

Remember, each file contains the daily temperature for each region. However, only two regions will be used in this exercise.

In this exercise, the lines from your previous exercise are already there which extract the data from each file. However, this time you will then store these variables in an array, calculate the average temperature of the regions and append this to the array.

For example, for temperatures of 60 and 70, the array should have 60, 70, and 65 as its elements.


    # Create variables from the temperature data files
    temp_b="$(cat temps/region_B)"
    temp_c="$(cat temps/region_C)"

    # Create an array with these variables as elements
    region_temps=($temp_b $temp_c)

    # Call an external program to get average temperature
    average_temp=$(echo "scale=2; (${region_temps[0]} + ${region_temps[1]}) / 2" | bc)

    # Append average temp to the array
    region_temps+=($average_temp)

    # Print out the whole array
    echo ${region_temps[@]}
