library("shiny")
library("shinyWidgets")
source("scripts/script.R")
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggmap)
library(plotly)
library(leaflet)

#read the csv files
covid_county <- read.csv("data/cleaned_data.csv",
                         stringsAsFactors = FALSE)

page_three <- tabPanel(
  "Interactive 3",
  titlePanel("V3"),
  sidebarLayout(
    slider3,
    main_content_3
  )
)
slider3 <- sidebarPanel(
  selectInput(
    inputId = "habbit",
    label = "Habbits",
    choices = c("percent_smokers", "percent_adults_with_obesity",
                "percent_excessive_drinking", "percent_physically_inactive",
                "percent_insufficient_sleep")
  )
)
main_content_3 <- mainPanel(
  plotOutput("vis_three")
)
