# Analysis on COVID-19 in the United States according to different states

rm(list = ls())

library(dplyr)
covid_cases <- read.csv("../data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

colnames(covid_cases) # column names
nrow(covid_cases) # number of rows
ncol(covid_cases) # number of columns

# Check if everything is tally
check_df <- covid_cases %>%
  mutate(answer = covid_cases$positiveIncrease +
covid_cases$negativeIncrease == covid_cases$totalTestResultsIncrease) %>%
  filter(answer == FALSE)
# Seems like one of the data entry for PR has a problem because it's
# not accurate.

# Count the total of testing manually
# function to get info for column
info_covid <- function(dataframe) {
  summary <- dataframe %>%
    group_by(state) %>%
    select(positiveIncrease, negativeIncrease) %>%
    summarize(total_positive_case = round(sum(positiveIncrease,
                                              na.rm = TRUE), 0),
              total_negative_case = round(sum(negativeIncrease,
                                              na.rm = TRUE), 0),
              total_testing = total_positive_case + total_negative_case,
              percent_positive = round(
                total_positive_case / total_testing * 100, 2)) %>%
              arrange(-percent_positive)
}

# this table will give out the summary for the testing conducted in the states
state_testing <- info_covid(covid_cases)

# Introduces the table, explaining why the particular grouping calculation was performed
# The table sumamrize total number of testing conducted in the states. 
# We can also know the percentage of positive cases from the total number of testing in
# the states. 

# Creates a summarized data frame to include as the table using group_by()
# Table of state_testing

# Intentionally sorts the table in a relevant way
# We purposely arrange the table descendingly according to the percentage of 
# positive cases in the states.

# Only displays relevant columns in the table
# The table shows the percentage of positive cases from the total number of
# testing according to states.
# Should I include the total number for positive, negative,and total testing?

# Displays well formatted column names
# When inserted the table in index.rmd, need to change the name of the columns

# Successfully renders the table in the report using an appropriate package
# (e.g., don't just print out the data frame)
# Put the table using kable function

# Interprets information the table, honing in on important information
# From the table, we can conclude that NJ has the highest percentage for positive
# COVID-19 cases among the states.
# We should notice that even NY has a significantly higher number of testing
# conducted than NJ, the percentage for positive cases in NY is lower than the NJ.