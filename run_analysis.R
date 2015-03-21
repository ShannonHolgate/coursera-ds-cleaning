## Add the required packaged if nescessary
req_packages <- c("dplyr", "tidyr")
if (length(setdiff(req_packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(req_packages, rownames(installed.packages()))) 
}
lapply(req_packages, require, character.only=T)

## Set the global names and activity files
column_names_file <- "UCI HAR Dataset/features.txt"
activity_labels_file <- "UCI HAR Dataset/activity_labels.txt"

setup_files <- function() {
  ## Download and unzip the file to the current directory
  zip_name <- "fuc_har.zip"
  if (!file.exists(zip_name)){
    con <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    download.file(con,zip_name)
    unzip(zipfile = zip_name)
  }
}

## Function to return the average of mean divided by standard deviation
## In the dataset
run_analysis <- function() {
  ## Download and unzip files if nescessary
  setup_files()
  
  ## Read in the measurment table
  measurements <- prep_column_names()
  ## Read in the activity table
  activities <- tbl_df(read.table(activity_labels_file, header = FALSE, sep = "",col.names=c("activity_id", "activity_name")))
  
  ## Setup the test categories
  result_file <- "UCI HAR Dataset/test/X_test.txt"; 
  activity_file <- "UCI HAR Dataset/test/y_test.txt"; 
  subject_file <- "UCI HAR Dataset/test/subject_test.txt"
  test_cat <- prep_category_results(result_file, activity_file, subject_file, activities, measurements)
  
  ## Setup the training categories
  result_file <- "UCI HAR Dataset/train/X_train.txt"; 
  activity_file <- "UCI HAR Dataset/train/y_train.txt"; 
  subject_file <- "UCI HAR Dataset/train/subject_train.txt"
  train_cat <- prep_category_results(result_file,activity_file,subject_file,activities,measurements)
  
  ## Get the standard deviation and mean columns of the bound test/training sets
  mean_and_std <- clean_mean_and_std(rbind(test_cat, train_cat))
  
  ## Return a tidy dataset containing the mean of the mean divided by standard deviation
  ## Ordered by activity and subject.
  return(get_mean_by_activity_subject(mean_and_std))
}

get_mean_by_activity_subject <- function(df) {
  ## Prettify column names
  names(df) <- gsub('mean', 'Mean', names(df))
  names(df) <- gsub('std', 'StdDeviation', names(df))
  
  ## Get the means of the two columns and return 
  return(summarise_each(group_by(df, activity_name, subject), funs(mean)))
}

clean_mean_and_std <- function(all_vars) {
  subset <- select(all_vars, matches("(subject)+|(activity_name)+|(mean)+|(std)+", ignore.case = FALSE))
  col_names_df <- data.frame(colname = colnames(subset))
  enriched_df <- mutate(col_names_df, colnameadjusted = paste("AverageOf", colname, sep=''))
  colnames(subset)[2:(ncol(subset)-1)] <- enriched_df[2:(nrow(enriched_df)-1),"colnameadjusted"]
  return(subset)
}

prep_column_names <- function() {
  ## Create raw data frame
  temp_df<-(as.data.frame(mutate(tbl_df(read.table(column_names_file, header = FALSE, sep = "")), unique_col = gsub("[^0-9A-Za-z///' ]", "",V2))))
  ## Build up the columns
  data <- mutate(tbl_df(temp_df), unique_col = gsub('^t', 'Time', unique_col))
  data <- mutate(tbl_df(data), unique_col = gsub('^f', 'Frequency', unique_col))
  data <- mutate(tbl_df(data), unique_col = gsub('Acc', 'Acceleration', unique_col))
  data <- mutate(tbl_df(data), unique_col = gsub('Mag', 'Magnitude', unique_col))
  data <- mutate(tbl_df(data), unique_col = gsub('GyroJerk', 'AngularAcceleration', unique_col))
  data <- mutate(tbl_df(data), unique_col = gsub('Gyro', 'AngularSpeed', unique_col))
  
  return(as.data.frame(data))    
}

prep_category_results <- function(result_file, activity_file, subject_file, activity_labels, measurements) {
  result_data <- read.table(result_file, header = FALSE, sep = "")
  
  ## Pretify column names
  colnames(result_data) <- measurements[,3]
  
  ## Labelling file
  activities <- read.table(activity_file, header = FALSE, sep = "")
  ## Insert test activity into dataset
  activity_results <- cbind(activities, result_data) 
  ## Rename activity column
  colnames(activity_results)[1] <- "activity_id"
  ## Join reference data to test data
  enriched_activity_df <- as.data.frame(inner_join(activity_results, activity_labels, by ="activity_id" ))
  
  ## Subject data
  subjects <- read.table(subject_file, header = FALSE, sep = "")
  ## Insert subject into dataset
  subject_activity_data <- cbind(subjects, enriched_activity_df)
  ## Rename subject column
  colnames(subject_activity_data)[1] <- "subject"
  
  ## Return the data
  return(subject_activity_data[, !duplicated(colnames(subject_activity_data))])
}