#Load Libraries
library("dplyr")
library("ggplot2")
library("stringr")

data_set <- read.csv("data/Provisional_COVID-19_Death_Counts_by_Sex__Age__and_State.csv",
                     stringsAsFactors = FALSE)

most_cases_covid_19 = data_set %>%
  group_by(State) %>%
  summarize(cases = sum(COVID.19.Deaths, na.rm = TRUE)) %>%
  filter(State != "United States" & State != "United States Total") %>%
  top_n(1)

get_summary_info <- function(data_set) {
  ret <- list (
    # place with most cases of covid_19
    place_most_cases_covid_19 = most_cases_covid_19 %>%
      pull(State),
    # the number of cases in this place
    num_most_cases = most_cases_covid_19 %>%
      pull(cases),
    # Age group in the US with most covid deaths
    us_age_group_biggest = data_set %>%
      filter(State == "United States", Age.group != "All ages",
             Sex == "All Sexes") %>%
      filter(COVID.19.Deaths == max(COVID.19.Deaths, na.rm = T)) %>%
      pull(Age.group),
   # The total deaths in the US due to the virus
    total_death_us = data_set %>%
      filter(State == "United States", Sex == "All Sexes") %>%
      summarize(Total.Deaths = sum(Total.Deaths)) %>%
      pull(Total.Deaths),
    # Sum of covid deaths for males
    covid_deaths_males = data_set%>%
      filter(Sex == "Male") %>%
      summarize(male_death = sum(COVID.19.Deaths, na.rm = T)) %>%
      pull(male_death),
    # Sum of covid deaths for females
    covid_deaths_females = data_set %>%
      filter(Sex == "Female") %>%
      summarize(female_death = sum(COVID.19.Deaths, na.rm = T)) %>%
      pull(female_death)
  )

  return(ret)
}
