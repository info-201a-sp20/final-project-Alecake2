library(dplyr)
library(tidyverse)
library("leaflet")

covid_cases <- read.csv("data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

states_coordinates <- read.csv(
  "data/world_country_and_usa_states_latitude_and_longitude_values.csv",
  stringsAsFactors = FALSE)

organized_coordi <- states_coordinates %>%
  select(usa_state_code, usa_state_latitude, usa_state_longitude) %>%
  na.omit() %>%
  rename(state = usa_state_code)

result_by_state <- covid_cases %>%
  select(state, positive, negative, totalTestResults) %>%
  group_by(state) %>% 
  summarise(
    positive = max(positive, na.rm = TRUE),
    negative = max(negative, na.rm = TRUE),
    totalTestResults = max(totalTestResults, na.rm = TRUE)
  ) %>% 
  full_join(organized_coordi) %>%
  mutate(positive_rate = positive/totalTestResults * 100) %>%
  mutate(radius = (positive / max(positive)) * 50)

plot_two <- leaflet(result_by_state) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -98.5685, lat = 39.82406, zoom = 4) %>%
  addCircleMarkers(
    lat = result_by_state$usa_state_latitude,
    lng = result_by_state$usa_state_longitude,
    radius = ~radius,
    popup = paste(
      "Total Test:", result_by_state$totalTestResults, "<br>",
      "Positive:", result_by_state$positive, "<br>",
      "Negative:", result_by_state$negative, "<br>",
      "State", result_by_state$state, "<br>",
      "Positive Rate", round(result_by_state$positive_rate,2), "%"
    )
  )

