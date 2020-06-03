######### Overview Page #########
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")

source("vis_2.R")
source("vis_1.R")
source("vis_3.R")
source("takeaway_1.R")

#introduction paragraph overview tag list
intro_paragraph <- list(
  tags$img(src = "https://fresnostate.edu/president/coronavirus/images/coronavirus-gov.jpg",
           alt = "Corona Virus"),
  p("Our project focuses on the effect of COVID-19 in the United States. This spring, we have this unfortunate outbreak of virus that has threathen hundreds of thoudsands of lives int the U.S., and even more around the world. Our group hopes that, with our effort and analysis on multiple datasets about the COVID-19, we can arouse more viligance and help people to stay wise during this special time.After looking through a few of datasets online, we raised a couple of data-driven question, and try to show our insight to these question by data gathering and data visualization.")
)

# dataset 1 description
data_1 <- list(tags$p("The first question is: what is the percentage of positive result from the total number of testing as date moving on from March to May.",
    "We will use the dataset us_states_covid19_daily.csv which give the daily count of COVID-19 cases in each day. The link of this dataset is ",
    tags$a(href="https://www.kaggle.com/sudalairajkumar/covid19-in-usa?select=us_states_covid19_daily.csv", "first dataset"))
)

data_2 <- list(
  tags$p("The second question is: What is the death rate in every age group for",
    "male and female. For this question we use tge provisional COVID-19 Death",
    "Counts dataset based on states, sex and ages that could help us understand", 
    "the bigger picture.The link of this dataset is "),
  tags$a(href="https://www.kaggle.com/paultimothymooney/latitude-and-longitude-for-every-country-and-state",
         "second dataset")   
)

data_3 <- list(
  tags$p("The thrid questin is: What effect does unhealthy habbit have on",
    "affecting rate. For this question we use a comprehensive one about each",
    "U.S county, which collects information related to their weather", 
    "socio/health and COVID-19 situation. Since its size exceeds the",
    "upload limit, we have cleaned and truncate it. The Link is: "),
  tags$a(href="https://www.kaggle.com/johnjdavisiv/us-counties-covid19-weather-sociohealth-data", "third dataset")
)

page_summary <- tabPanel(
  "Summary Takeaways",
  titlePanel("Summary Takeaways"),
  
  # Takeaway for Interactive One
  h3("Interactive One"),
  
  p("From the interactive map, we can see that the rising positive rates in
    the East Coast of the US as the dates approached May. We can also see
    the beginning spread of COVID-19 cases spikes in early March, although
    the first case was in Washington state at the end of January. The map
    below mapped on March 5, which indicates the starting of the pandemic
    across the states."),
  
  img(map_may_5),
  
  p("The spiking of positive rates in the East Coast in March implies the delay
  in testing conducted in those areas causing the wild spread of the
  virus. Besides, we might want to question the effectiveness of our way of
  conducting testing because our way of testing can control the spread of the
  disease, especially in communities."),
  
  h3("Interactive Two"),
  
  p("Takeaway 2:"),
  
  h3("Interactive Three"),
  
  p("\n Takeaway 3:"),
)

?img()

page_intro <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  tagList(intro_paragraph,
          data_1,
          data_2,
          data_3
  )
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

