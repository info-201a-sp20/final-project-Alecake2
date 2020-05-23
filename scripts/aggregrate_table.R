# Analysis on COVID-19 in the United States according to different states

rm(list = ls())

library(dplyr)

covid_cases <- read.csv("../data/us_states_covid19_daily.csv", stringsAsFactors = FALSE)

colnames(covid_cases) # column names
nrow(covid_cases) # number of rows
ncol(covid_cases) # number of columns

# Check if everything is tally
check_df <- covid_cases %>% 
  mutate(answer = covid_cases$positiveIncrease + covid_cases$negativeIncrease == covid_cases$totalTestResultsIncrease) %>% 
  filter(answer == FALSE)
# Seems like one of the data entry for PR has a problem because it's not accurate

# Count the total of testing manually
# function to get info for column
info_covid <- function(dataframe) {
  summary <- dataframe %>% 
    group_by(state) %>%
    select(positiveIncrease, negativeIncrease) %>% 
    summarize(total_positive_case = round(sum(positiveIncrease, na.rm = TRUE), 0),
              total_negative_case = round(sum(negativeIncrease, na.rm = TRUE), 0),
              total_testing = total_positive_case + total_negative_case,
              percent_positive = round(total_positive_case / total_testing * 100, 2)) %>%
              arrange(-percent_positive)
}

# this table will give out the summary for the testing conducted in the states
state_testing <- info_covid(covid_cases)