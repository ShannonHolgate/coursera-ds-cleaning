#Code Book

##Data Sources
The data studied in this project is the UCI HAR Dataset available [here]("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

Dataset information:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For each record in the dataset it is provided: 

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Each piece of data is split across the following files:

* features.txt': List of all variables measured.
* activity_labels.txt': Lookup data to map identifier and description of the activity performed.
* train/X_train.txt': Training set of observations.
* train/y_train.txt': Training labels.
* train/subject_train.txt': Identifier of each subject for which the observations belong.
* test/X_test.txt': Test set of observations.
* test/y_test.txt': Test labels.
* test/subject_test.txt': Identifier of each subject for which the observations belong.

##Description of Data

The data repository will be sourced and unzipped to the current working directory to create the 'UCI HAR Dataset' directory containing the datasets above.

`activity_name` <- The name reference of the activity performed by the subject

`subject` <- Numeric ID of the subject performing the activity

`3:81` <- Measurement Variables defining averages of each variable in the UCI HAR dataset for each activity and subject

The following variables have been renamed to make them readable and more descriptive:

* Special characters such as '()/-_' have been removed
* `t` has been replaced with `Time`
* `f` has been replaced with `Frequency`
* `Mag` has been replaced with `Magnitude`
* `GyroJerk` has been replaced with `AngularAcceleration`
* `Gyro` has been replaced with `AngularSpeed`
* `mean` has been replaced with `Mean`
* `std` has been replaced with `StdDeviation`
* `AverageOf` has been prefixed to the variable name

| Column            				| Description                                                                  |
|-----------------------------------|------------------------------------------------------------------------------|
| activty_name      				| Activity name as mapped from ActivtyId to Label using `activity_labels.txt`  |
| subject           				| Subject value                                                                |
| AverageOfTimeBodyAccelerationMeanX| Average value from combined test and training data sets                      |
| AverageOfTimeBodyAccelerationMeanY| Average value from combined test and training data sets                      |
| AverageOfTimeBodyAccelerationMeanZ| ...                                                                          |
