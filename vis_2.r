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
most_cases_covid_19 <- data_set %>%
  filter(State == "United States") 
  



# Create Visualizations for Page 2
var1_vis1 <- sidebarLayout(
  sidebarPanel(
    selectInput(inputId = "gender" ,
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
  ),
  mainPanel(
    
  )
)

# Vis 2
vis_2 <- tabPanel(
 
)

