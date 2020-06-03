library("shiny")
library("shinyWidgets")
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggmap)
library(plotly)
library(leaflet)

#read the csv files
covid_county <- read.csv("data/cleaned_data.csv",
                         stringsAsFactors = FALSE)

slider3 <- sidebarPanel(
  selectInput(
    inputId = "habit",
    label = "Habits",
    choices = c("Smoking", 
                "Obesity",
                "Drinking", 
                "Inactive",
                "Lack_Sleep"),
    selected = "Smoking"
  )
)

  main_content_3 <- mainPanel(
  #here make your title
  tags$h3("COVID_19 Death Rate and Unhealthy Habits"),
  tags$p(class = "desciption",
         "This position chart explore the death rate in different counties in
         the US based on different unhealthy habits. The chart means to 
         discover if unhealthy habits have any relation with the death
         rate of COVID-19"),
  plotOutput("vis_three")
  )

page_three <- tabPanel(
  "Interactive 3",
  titlePanel("Association Between Covid-19 Death Rate and Unhealthy Habits"),
  sidebarLayout(
    slider3,
    main_content_3
  )
)