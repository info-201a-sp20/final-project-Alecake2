# Visualization 2
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")

covid_deaths <-
  read.csv("data/Provisional_COVID-19_Death_Counts_by_Sex__Age__and_State.csv",
           stringsAsFactors = FALSE, encoding = "UTF-8"
  )
most_cases_covid_19 <- covid_deaths %>%
  filter(State == "United States") 

# Create Visualizations for Page 2
slider2 <- sidebarPanel(
    selectInput("gender",
                label = h1("Choose a gender"),
                choices = list(
                  "All Sexes" = "All Sexes",
                  "All Sexes Total" = "All Sexes Total",
                  "Male" = "Male",
                  "Male Total" = "Male Total",
                  "Female" = "Female",
                  "Female Total" = "Female Total",
                  "Unknown" = "Unknown"
                ),
                selected = "All Sexes"
    )
)
page_two_main <- mainPanel(
  tags$h1("COVID 19 Deaths by gender"),
  tags$p(
    id = "vis1_descrip",
    "This page aims to display Covid 19 Data. This graph shows the
    Covid 19 death age groups depending on which gender you
    choose (You can select which gender from the side bar)",
  ),
  plotlyOutput("page2")
)

# Visualization 2
page_two <- tabPanel(
  "COVID 19 Cases by Gender",
  titlePanel("Comparing COVID 19 Cases by gender versus age group"),
  
  sidebarLayout(
    slider2,
    page_two_main
  )
)

