library(dplyr)
library(tidyverse)
library(scales)
library(gridExtra)
library(ggthemes)
library("plotly")
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
    positive = sum(positive, na.rm = TRUE),
    negative = sum(negative, na.rm = TRUE),
    totalTestResults = sum(totalTestResults, na.rm = TRUE)
  ) %>% 
  full_join(organized_coordi)


result_by_state <-  result_by_state %>%
  mutate(radius = (positive / max(positive)) * 50)

test_map <- leaflet(result_by_state) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -98.5685, lat = 39.82406, zoom = 4) %>%
  addCircleMarkers(
    # latitudes of incidents
    lat = result_by_state$usa_state_latitude,
    # longitudes of incidents
    lng = result_by_state$usa_state_longitude,
    # set the size of each marker base on people killed

    radius = ~radius,
    popup = paste(
      "Total Test:", result_by_state$totalTestResults, "<br>",
      "Positive:", result_by_state$positive, "<br>",
      "Negative:", result_by_state$negative, "<br>",
      "State", result_by_state$state
    )
  )

