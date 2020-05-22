# Analysis on COVID-19 in the United States according to different states

rm(list = ls())

library(dplyr)

covid_cases <- read.csv("../data/us_states_covid19_daily.csv", stringsAsFactors = FALSE)

colnames(covid_cases) # column names
nrow(covid_cases) # number of rows
ncol(covid_cases) # number of columns

# function to get info for column
info_covid <- function(dataframe) {
  summary <- dataframe %>% 
    group_by(state) %>%
    select(positiveIncrease, negativeIncrease, totalTestResultsIncrease) %>% 
    summarize(total_positive_case = round(sum(positiveIncrease, na.rm = TRUE), 0),
              total_negative_case = round(sum(negativeIncrease, na.rm = TRUE), 0),
              total_testing = round(sum(totalTestResultsIncrease, na.rm = TRUE), 0),
              percent_positive = round(total_positive_case / total_testing * 100, 2)) %>% 
    arrange(-percent_positive)
}

# this table will give out the summary for the testing conducted in the states
state_testing <- info_covid(covid_cases)

# Check if everything is tally
state_testing$total_testing == state_testing$total_positive_case + state_testing$total_negative_case
# Seems like the result for PR has a problem

# Covid for PR
PR_covid <- covid_cases %>% filter(state == "PR")

covid_check <- all(covid_cases$positiveIncrease + covid_cases$negativeIncrease == covid_cases$totalTestResultsIncrease) == TRUE 

# Data set for covid cases in PR states is not accurate
