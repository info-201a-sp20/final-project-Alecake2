######### Overview Page #########
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")
source("vis_2.R")
source("vis_1.R")
ui <- fluidPage(
  includeCSS("style.css"),
  h1("Info 201 Final Delivarable BF-3"),
  h2(em("COVID-19"), "Data Analysis and Conclusion"),
  p("overview"),
  nav
)

# Define content for the second page

# Define content for the third page
page_three <- tabPanel(
  "Interactive 3",
  titlePanel("Third Interactive: ")
)

page_summary <- tabPanel (
  "Summary Takeaways",
  titlePanel("Summary Takeaways")
)

# Pass each page to a multi-page layout
nav <- navbarPage(
  "Navigation Bar",
  page_one,
  page_two,
  page_three,
  page_summary
)
######### First Interactive ###########

######### Second Interactive ##########

######### Third Interactive ###########

######### Summary takeaways ###########