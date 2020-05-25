library(tidyverse)
library(scales)
library(gridExtra)
library(ggthemes)
library(dplyr)
library("plotly")
library("rbokeh")
covid_cases <- read.csv("../data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

result_by_state <- covid_cases %>%
  select(state, hospitalizedCumulative, recovered) %>%
  group_by(state) %>% 
  #na.omit() %>%
  summarise(
    hospitalize = max(hospitalizedCumulative, na.rm = TRUE),
    recovered = max(recovered, na.rm = TRUE)
  )

plot_ly(
  data = result_by_state, 
  x = ~hospitalize,
  y = ~recovered,
  type = "scatter",
  mode = "markers"
)


figure(
  data = result_by_state,
  title = "Hospitalized By State"
) %>% 
  ly_points(
    hospitalize, 
    recovered,
    color = "red"
  )



ggplotly(
  ggplot(result_by_state, aes(x = state, y = hospitalize)) +
    #geom_col(fill = "red") +
    geom_bar(position="dodge",stat="identity") + 
    coord_flip() +
    ggtitle("Hospitalize by State") +
    xlab("State") +
    ylab("Tests")
)