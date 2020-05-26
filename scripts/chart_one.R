library("tidyverse")
library("scales")
library("gridExtra")
library("ggthemes")
library("dplyr")
library("plotly")
library("rbokeh")
covid_cases <- read.csv("data/us_states_covid19_daily.csv",
                        stringsAsFactors = FALSE)

result_by_state <- covid_cases %>%
  select(state, hospitalizedCumulative, recovered) %>%
  group_by(state) %>% 
  #na.omit() %>%
  summarise(
    hospitalize = max(hospitalizedCumulative, na.rm = TRUE),
    recovered = max(recovered, na.rm = TRUE)
  ) %>%
  arrange(hospitalize)


plot_one <- ggplotly(
  ggplot(result_by_state, aes(x = state, y = hospitalize)) +
    #geom_col(fill = "red") +
    geom_bar(position="dodge",stat="identity") + 
    coord_flip() +
    ggtitle("Hospitalized Number by State") +
    xlab("State") +
    ylab("Number of Hospitalized People")
  )
