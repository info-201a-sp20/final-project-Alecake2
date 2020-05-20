# Analysis on COVID-19 in the United States according to different states

rm(list = ls())

library(dplyr)

covid_cases <- read.csv("data/us_states_covid19_daily.csv", stringsAsFactors = FALSE)

colnames(covid_cases) #column names
nrow(covid_cases) #`number of rows
ncol(covid_cases) # number of columns

# function to get info for column
info_covid <- function(dataframe) {
  summary <- dataframe %>% 
    group_by(state) %>%
    select(positiveIncrease, negativeIncrease, totalTestResultsIncrease) %>% 
    summarize(mean_positve_case = round(mean(positiveIncrease, na.rm = TRUE),0),
              total_positive_case = round(sum(positiveIncrease, na.rm = TRUE),0),
              mean_negative_case = round(mean(negativeIncrease, na.rm = TRUE),0),
              total_negative_case = round(sum(negativeIncrease, na.rm = TRUE),0),
              mean_num_cases = round(mean(totalTestResultsIncrease, na.rm = TRUE),0),
              total_num_cases = round(sum(totalTestResultsIncrease, na.rm = TRUE),0),
              ) %>% 
    arrange(-total_num_cases) 
}

# this table will give out the summary for the testing conducted in the states
state_testing <- info_covid(covid_cases)

