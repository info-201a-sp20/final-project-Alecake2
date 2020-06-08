# Load libraries
library(shiny)
library(dplyr)
library(leaflet)

# Read in data
source("scripts/build_map.R")

# Add slider for choosing date
slider <- sidebarPanel(
  sliderInput("plot_date",
              "Select mapping date",
              min = min(covid_cases$date),
              max = max(covid_cases$date),
              value = min(covid_cases$date),
              timeFormat = "%d %b",
              animate = animationOptions(interval = 3000, loop = FALSE)))

# Add interactive map
main_content <- mainPanel(
  leafletOutput("map", width = 1000, height = 550))

# Add variable for ui
page_one <- tabPanel(
  "Interactive 1",
  titlePanel("Positive Rate of COVID-19 in the United States"),

  p(class = "description",
  "We want to know how many testing has been conducted daily
  in each state, and we also want to analyze the positive rate
  of the coronavirus across the U.S. The positive rate represents the
  percentage of positive cases out of the number of testing conducted
  according to states. The interactive map illustrates the pattern of
  the positive rates for COVID-19 in the U.S. from January 22 to May
  12, 2020. We decided to exclude Puerto Rico(PR) state because the
  data for this state is not reliable enough."),

  sidebarLayout(
    slider,
    main_content)
)
