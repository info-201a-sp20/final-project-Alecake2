#Load Libraries
library("dplyr")
library("ggplot2")
library("stringr")

data_set <- read.csv("data/Provisional_COVID-19_Death_Counts_by_Sex__Age__and_State.csv", stringsAsFactors = FALSE)

get_summary_info <- function(data_set) {
  ret <- list (
    # Max covid deaths in the US
    max_cases_covid_19 = select(data_set, COVID.19.Deaths) %>%
      filter(State == United_States, Sex = All Sexes) %>%
      summarize(max_cases = max(COVID.19.Deaths)) %>%
      pull(COVID-19),
    # State with most covid deaths
    state_most_cases_covid_19 = select(data_set, state, COVID.19.Deaths) %>%
      group_by(state) %>%
      summarize(avg_cases = avg(COVID.19.Deaths)) %>%
      filter(Max_cases = max(avg_cases), state != United States) %>%
      pull(state), 
    # Age group in the US with most covid deaths
    us_age_group_biggest = select(data_set, COVID.19.Deaths, Age group) %>%
      filter(State == United_States, age_group != All ages, sex = All Sexes, max_covid = max(COVID.19.Deaths)) %>%
      pull(age_group),
   # Max total deaths in the US 
    max_total_death_us = select(data_set, Total.Deaths) %>%
      filter(State == United_States, sex = All Sexes) %>%
      summarize(max_cases = max(Total.Deaths)) %>%
      pull(Total.Deaths),
    # Avg covid deaths for males
   avg_covid_deaths_males = select(data_set, COVID.19.Deaths) %>%
      filter(sex = Male) %>%
      summarize(avg_male_death = avg(COVID.19.Deaths)) %>%
      pull(avg_male_death),
   # Avg covid deaths for females
   avg_covid_deaths_females = select(data_set, COVID.19.Deaths) %>%
     filter(sex = Female) %>%
     summarize(avg_female_death = avg(COVID.19.Deaths)) %>%
     pull(avg_female_death)
      
  )
  
  return(ret)
}

