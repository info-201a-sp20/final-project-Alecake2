#Load Libraries
library("dplyr")
library("ggplot2")
library("stringr")

data_set <- read.csv("data/Provisional_COVID-19_Death_Counts_by_Sex__Age__and_State.csv", stringsAsFactors = FALSE)

get_summary_info <- function(data_set = data_set) {
  ret <- list (
    # Max covid deaths in the US
    max_cases_covid_19 = data_set %>%
      filter(State == "United States", Sex == "All Sexes") %>%
      summarize(max_cases = max(COVID.19.Deaths)) %>%
      pull(max_cases),
    # State with most covid deaths
    State_most_cases_covid_19 = select(data_set, State, COVID.19.Deaths) %>%
      group_by(State) %>%
      summarize(avg_cases = mean(COVID.19.Deaths)) %>%
      filter(avg_cases == max(avg_cases), State != "United States") %>%
      pull(State),
    # Age group in the US with most covid deaths
    us_age_group_biggest = select(data_set, State, Sex, COVID.19.Deaths, Age.group) %>%
      filter(State == "United States", Age.group != "All ages",
             Sex == "All Sexes", COVID.19.Deaths == max(COVID.19.Deaths)) %>%
      pull(Age.group),
    # Max total deaths in the US
    max_total_death_us = select(data_set, State, Sex, Total.Deaths) %>%
      filter(State == "United States", Sex == "All Sexes") %>%
      summarize(Total.Deaths = max(Total.Deaths)) %>%
      pull(Total.Deaths),
    us_age_group_biggest = data_set %>%
      filter(State == "United States", Age.group != "All Ages", Sex == "All Sexes", COVID.19.Deaths == max(COVID.19.Deaths)) %>%
      pull(Age.group),
   # Max total deaths in the US
    max_total_death_us = data_set %>%
      filter(State == "United States", Sex == "All Sexes") %>%
      summarize(Total.Deaths = max(Total.Deaths)) %>%
      pull(Total.Deaths),
    # Avg covid deaths for males
    avg_covid_deaths_males = data_set%>%
      filter(Sex == "Male") %>%
      summarize(avg_male_death = mean(COVID.19.Deaths)) %>%
      pull(avg_male_death),
    # Avg covid deaths for females
    avg_covid_deaths_females = select(data_set, Sex, COVID.19.Deaths) %>%
      filter(Sex == "Female") %>%
      summarize(avg_female_death = mean(COVID.19.Deaths)) %>%
      pull(avg_female_death)
  )

  return(ret)
}
