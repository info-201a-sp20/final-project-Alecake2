library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
source("my_server.R")
source("my_ui.R")

shinyApp(ui = ui, server = server)
