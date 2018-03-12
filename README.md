# Getting and Cleaning Data Project
# The file contains the details for the execution of the code present in run_analysis.R

# Below are the steps happening in run_analysis.R

1. Install the required packages and library.
2. At the beginning we are downloading the data sets from the below link and unziping the files.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. Read the test and training data and store them into the variables.
4. Along with reading the data assign the column names to the dataset.
5. Combine all the columns using cbind() for test and train datasets.
6. Merge all the rows of test and train data set into combined dataset.
7. Extracts all the required mean and standard deviation columns from combined dataset into extractedcolumn dataset along with SubjectID and ActivityID.
8. Now convert all the ActivityID into their descriptions.
9. Convert all the column names with the full abbreviations.
10. Now use aggregate function on SubjectID and ActivityID with taking average of each measurements and store them into Tidydata dataset.
11. Write the Tidydata onto a Tidy_Data.txt file.

