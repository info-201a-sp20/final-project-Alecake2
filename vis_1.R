# Load libraries
library(shiny)
library(dplyr)
library(leaflet)

# Read in data
source("scripts/build_map.R")

# Add slider for choosing date
slider <- absolutePanel(
  sliderInput("plot_date",
              "Select mapping date",
              min = min(covid_cases$date),
              max = max(covid_cases$date),
              value = min(covid_cases$date),
              timeFormat = "%d %b",
              animate = animationOptions(interval = 3000, loop = FALSE)),
  draggable = TRUE, top = "auto", left = 40, right = "auto", bottom = 90,
  width = 330, height = "auto")

# Add interactive map
main_content <- mainPanel(
  leafletOutput("map", width = 1300, height = 550))

# Add variable for ui
page_one <- tabPanel(
  "Interactive 1",
  titlePanel("Positive Rate over all Testing Conducted in each State"),
  
  p("We are interested to know the detail on testing conducted for each
    state in the US. The positive rate represents the number of posiitve
    cases out of the number of testing conducted in each state. The
    interactive map shows the pattern of the positive rates of COVID-19
      cases in the US from January 22 to May 12, 2020. We excluded Puerto Rico because
    the data is not reliable enough."),
  
  sidebarLayout(
    slider,
    main_content)
)
