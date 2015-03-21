# Getting and Cleaning Data - Coursera
Getting and Cleaning Data Project to run the analysis of the UCI HAR datasets. Part of the [Coursera Data Science Specialisation](https://www.coursera.org/specialization/jhudatascience/1).

Refer to the CodeBook.md for information on the R code and any descriptions of the data required.

## R Script
All Code is in the single `run_analysis.R` script contained in this repository. There are **no pre-requisites, except R,** to running this script provided you are not behind any tight firewall rules. If you are you _may_ need to download this dataset: [UCI HAR Dataset]("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") and unzip it in the current working directory.
 
The `run_analysis()` function contained in the `run_analysis.R` script will run the complete analysis and download any files or libraries required. It would be wise to set your working directory to a development directory before running the script. 

To run the analysis follow these steps in R or RStudio:

```
source('./run_analysis.R')
output <- run_analysis()
View(output)
```