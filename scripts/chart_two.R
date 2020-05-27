# Set Up
library("tidyverse")
library("leaflet")

# Load the data needed for the chart
covid_cases <- read.csv("data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

# Load the dataframe that contains coordinates of
# every states in the U.S.
states_coordinates <- read.csv(
  "data/world_country_and_usa_states_latitude_and_longitude_values.csv",
  stringsAsFactors = FALSE)

# Extract the initial of every state in the
# U.S. and its central coordinates.
organized_coordi <- states_coordinates %>%
  select(usa_state_code, usa_state_latitude, usa_state_longitude) %>%
  na.omit() %>%
  rename(state = usa_state_code)

# Extract the number of covid-19 test and
# test results for each state. After storing
# them into a dataframe, combine it with the
# dataframe that contains the coordinates of
# every state in the U.S..
result_by_state <- covid_cases %>%
  select(state, positive, negative, totalTestResults) %>%
  group_by(state) %>%
  summarise(
    positive = max(positive, na.rm = TRUE),
    negative = max(negative, na.rm = TRUE),
    totalTestResults = max(totalTestResults, na.rm = TRUE)
  ) %>%
  full_join(organized_coordi) %>%
  mutate(positive_rate = positive / totalTestResults * 100) %>%
  mutate(radius = (positive / max(positive)) * 50)

# The function takes in a df and create a map that has a
# marker on the center of each state in the U.S., the size
# of each marker is proportional to the number of positve
# cases of corresponding state.
create_map <- function(df) {
  leaflet(df) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -98.5685, lat = 39.82406, zoom = 4) %>%
  addCircleMarkers(
    lat = result_by_state$usa_state_latitude,
    lng = result_by_state$usa_state_longitude,
    radius = ~radius,
    # Upon hovering on the markers, the total number of test,
    # postive cases, negative cases, state name, and positive
    # rate will popup.
    popup = paste(
      "Total Test:", result_by_state$totalTestResults, "<br>",
      "Positive:", result_by_state$positive, "<br>",
      "Negative:", result_by_state$negative, "<br>",
      "State", result_by_state$state, "<br>",
      "Positive Rate", round(result_by_state$positive_rate, 2), "%"
    )
  )
}

# Create a map by using the dataframe manipulated earlier.
plot_two <- create_map(result_by_state)
