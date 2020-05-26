library(tidyverse)
library(scales)
library(gridExtra)
library(ggthemes)
library(dplyr)
library("plotly")
library("rbokeh")
covid_cases <- read.csv("data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

df <- covid_cases %>%
  select(date, positive) %>%
  group_by(date) %>%
  summarise(positive = sum(positive))

df$date <- as.character(df$date)

#everyday positive
plot_three <- plot_ly(
  data = df,
  x = ~date,
  y = ~positive,
  type = "scatter",
  mode = "markers"
) 
