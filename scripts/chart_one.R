library(tidyverse)
library(scales)
library(gridExtra)
library(ggthemes)
library(dplyr)
library("plotly")
covid_cases <- read.csv("../data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

result_by_state <- covid_cases %>%
  select(state, positive, negative, totalTestResults) %>%
  group_by(state) %>% 
  summarise(
    positive = sum(positive, na.rm = TRUE),
    negative = sum(negative, na.rm = TRUE),
    totalTestResults = sum(totalTestResults, na.rm = TRUE)
  )


ggplotly(
  ggplot(result_by_state, aes(x = state, y = totalTestResults)) +
    geom_col(fill = "red") +
    ggtitle("Testing Result by State") +
    xlab("State") +
    ylab("Tests")
)