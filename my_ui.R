######### Overview Page #########
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")

source("vis_2.R")
source("vis_1.R")
source("vis_3.R")

page_intro <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  tagList(intro_paragraph,
          data_1
          # data_2,
          # data_3
  )
)

#introduction paragraph overview tag list
intro_paragraph <- list(
  tags$img(src = "https://fresnostate.edu/president/coronavirus/images/coronavirus-gov.jpg",
           alt = "Corona Virus"),
  p("Our project focuses on the effect of COVID-19 in the United States. This spring, we have this unfortunate outbreak of virus that has threathen hundreds of thoudsands of lives int the U.S., and even more around the world. Our group hopes that, with our effort and analysis on multiple datasets about the COVID-19, we can arouse more viligance and help people to stay wise during this special time.After looking through a few of datasets online, we raised a couple of data-driven question, and try to show our insight to these question by data gathering and data visualization.")
)

# dataset 1 description
data_1 <- list(tags$p("The first question is: what is the percentage of positive result from the total number of testing as date moving on from March to May.",
    "We will use the dataset us_states_covid19_daily.csv which give the daily count of COVID-19 cases in each day. The link of this dataset is "),
              tags$a(href="https://www.kaggle.com/sudalairajkumar/covid19-in-usa?select=us_states_covid19_daily.csv", "first dataset")
)

page_summary <- tabPanel(
  "Summary Takeaways",
  titlePanel("Summary Takeaways"),
  p("Takeaway 1: \n Takeaway 2: \n Takeaway 3:")
)

# Pass each page to a multi-page layout navigation bar
nav <- navbarPage(
  "Navigation Bar",
  page_intro,
  page_one,
  page_two,
  page_three,
  page_summary
)

# create a page with the title of project and overview
ui <- fluidPage(
  includeCSS("style.css"),
  h1("Info 201 Final Delivarable BF-3"),
  h2(em("COVID-19"), "Data Analysis and Conclusion"),
  nav
)

