# Getting_Cleaning_Data

So this run_analysis.R program does the following:

- loads the reshape library for use at the end to melt the data properly

- downloads the file from the web for people to see the source of the original data

- loads up into R some of the labels and column names for the files provided and also pulls out the mean and std columns 

- loads up the x and y test files and applies the labels and column names to each

- loads up the x and y training files and applies the labels and column names to each using virtually the same code as before

-  binds the two data sets together

-  applies the labels and reshapes the data using the melt command

- exports the data into a .txt file called FinalDta.txt with row.name = FALSE as instructed
