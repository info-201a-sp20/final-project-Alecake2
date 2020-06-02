library("shiny")
library("shinyWidgets")
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggmap)
library(plotly)
library(leaflet)

ui <- fluidPage(
  titlePanel("V3"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "habbit",
        label = "Habbits",
        choices = c("percent_smokers", "percent_adults_with_obesity",
                    "percent_excessive_drinking", "percent_physically_inactive",
                    "percent_insufficient_sleep")
      )
    ),
    mainPanel(
      plotOutput(outputId = "vis_three")
    )
  )
)