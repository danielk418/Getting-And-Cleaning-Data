# Uses data from the Human Activity Recognition Using Smartphones Dataset for analysis. 
# Steps that were taken: reads in the test and training data observations, along with subjects and the activity labels. 
#                        combines test and training observations into one data set. 
#                        creates new data set keeping the variable names that are associated with averages or standard deviations. 
#                        variable names are updated to tidier names (abbrevations spelled out, lowercase, etc.)
#                        tidy_data dataframe is then created. The average is computed for each measurement variable grouped by the subject_id and activities variables.
# Variables of the tidy_data set are:
#                       subjectid - An id that designates the person that was involved in collecting the observation data. 
#                       activity - The activity the subjectid (person) was involved in when the observation was made. 
#                       avg of measurement variable - The average of the values based on the given subjectid, per activity.
