# Load libraries so they are available.
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")

# Use source() to execute the `my_ui.R` and `my_server.R` files.
source("my_server.R")
source("my_ui.R")

shinyApp(ui = ui, server = server)