library("shiny")
library("shinyWidgets")
source("scripts/vis_3_scattet.R")
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
    inputId = "habbit",
    label = "Habbits",
    choices = c("percent_smokers",
                "percent_adults_with_obesity",
                "percent_excessive_drinking",
                "percent_physically_inactive",
                "percent_insufficient_sleep"),
    selected = "percent_smokers"
  )
)

main_content_3 <- mainPanel(
  #here make your title
  tags$h3("v3 title"),
  # here your description
  tags$p(""),
  plotOutput("vis_three")
)

page_three <- tabPanel(
  "Interactive 3",
  titlePanel("V3"),
  sidebarLayout(
    slider3,
    main_content_3
  )
)