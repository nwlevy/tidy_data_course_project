# tidy_data_course_project
course project for Getting and Cleaning Data

##Breakdown of runanalysis.R

###Step 1: Gathering the Data

The R script begins by reading in the variable observations, activities, and participant numbers for the train test set, and concatenating them all together using the cbind function.  It then perfoms these same operations on the test data set.  When the two data sets are available in identically-structured data frames, the script merges them together using the rbind() function.

###Step 2: Extracting the Relevant Measurements

Next, the R script reads in a two-dimensional data fram containing the feature numbers and their corresponding names.  It then uses the grep() function to fetch the indices of the features that end with mean() or std().  Finally, it creates a new dataframe that only contains the participant number, the activity, and the relevant features based on these indices.

###Step 3: Assign Descriptive Names to the Activities

The R script converts the integers in the activity column to factors based on the mapping in the README file for the "Human Activity Recognition Using Smartphones Dataset."

###Step 4: Add Descriptive Variable Names to the Variables

The R script uses a series of gsub() functions to convert the abbreviated text in the given variable names to more readable labels.  It then adds these new names to newcomb with the colnames() function.

###Step 5: Create Tidy Data Set

The R script melts newcomb, and then uses the dcast() function in order to group the data by participant id and then by activity.  It specifies the mean function when it calls the dcast function in order fetch the mean for each group.
