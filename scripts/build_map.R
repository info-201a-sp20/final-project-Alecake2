library(lintr)
# Set Up
library("tidyverse")
library("leaflet")

# Load the data needed for the chart
covid_cases <- read.csv("./data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)
# Update the date column
covid_cases$date <- as.Date(as.character(covid_cases$date), format = "%Y%m%d")

# Load the dataframe that contains coordinates of
# every states in the U.S.
states_coordinates <- read.csv(
  "./data/world_country_and_usa_states_latitude_and_longitude_values.csv",
  stringsAsFactors = FALSE)

# Extract the initial of every state in the
# U.S. and its central coordinates.
organized_coordi <- states_coordinates %>%
  select(usa_state_code, usa_state_latitude, usa_state_longitude) %>%
  na.omit() %>%
  rename(state = usa_state_code)

# Extract the number of covid-19 test and
# test result for each state on the chosen
# date (date in string).

result_by_date <- function(str_date) {
  covid_cases %>%
    select(date, state, positive, negative, totalTestResults) %>%
    filter(date == str_date) %>%
    mutate(positive_rate = positive / totalTestResults * 100,
           radius = (positive_rate / 100) * 50) %>%
    full_join(organized_coordi) %>%
    filter(positive_rate >= 0)
}

# The function takes in a date and create a map that has a
# marker on the center of each state in the U.S., the size
# of each marker is proportional to the number of positve
# cases of corresponding state.
create_map <- function(df) {
  leaflet(df) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -98.5685, lat = 39.82406, zoom = 4) %>%
    addCircleMarkers(
      lat = df$usa_state_latitude,
      lng = df$usa_state_longitude,
      radius = ~radius,
      color = "red",
      stroke = FALSE, fillOpacity = 0.5,
      # Upon hovering on the markers, the total number of test,
      # postive cases, negative cases, state name, and positive
      # rate will popup.
      popup = paste(
        "State:", df$state, "<br>",
        "Total Test:", df$totalTestResults, "<br>",
        "Positive:", df$positive, "<br>",
        "Negative:", df$negative, "<br>",
        "Positive Rate:", round(df$positive_rate, 2), "%"
      )
    )
}

# Combined the both functions into one function. Use date(in string)
# for plotting the graph.
build_map <- function(str_date) {
  # create dataframe for chosen date
  df <- covid_cases %>%
    select(date, state, positive, negative, totalTestResults) %>%
    filter(date == str_date) %>%
    mutate(positive_rate = positive / totalTestResults * 100,
           radius = (positive_rate / 100) * 50) %>%
    full_join(organized_coordi) %>%
    filter(positive_rate >= 0,
           state != "PR")

  # create a map by using the dataframe manipulated earlier.
  p <- leaflet(df) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -90, lat = 35, zoom = 4.45) %>%
    addCircleMarkers(
      lat = df$usa_state_latitude,
      lng = df$usa_state_longitude,
      radius = ~radius,
      color = "red",
      stroke = FALSE,
      fillOpacity = 0.45,
      # Upon hovering on the markers, the total number of test,
      # postive cases, negative cases, state name, and positive
      # rate will popup.
      popup = paste(
        "State:", df$state, "<br>",
        "Total Test:", df$totalTestResults, "<br>",
        "Positive:", df$positive, "<br>",
        "Negative:", df$negative, "<br>",
        "Positive Rate:", round(df$positive_rate, 2), "%"
      )
    )
  return(p)
}
