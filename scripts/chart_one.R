library("tidyverse")
library("scales")
library("gridExtra")
library("ggthemes")
library("dplyr")
library("plotly")
library("rbokeh")
covid_cases <- read.csv("data/us-counties.csv",
                        stringsAsFactors = FALSE)
state_name <- read.csv("data/world_country_and_usa_states_latitude_and_longitude_values.csv",
                       stringsAsFactors = FALSE)

result_by_state <- state_name %>%
  select(usa_state, usa_state_code)%>%
  rename(state = usa_state) %>%
  full_join(covid_cases) %>%
  select(state, cases, deaths, usa_state_code) %>%
  group_by(state) %>% 
  summarise(
    cases = max(cases, na.rm = TRUE),
    deaths = max(deaths, na.rm = TRUE),
    state_code = max(usa_state_code),
  ) %>%
  arrange(-cases)



plot_one <- ggplotly(
  ggplot(result_by_state, aes(x = state_code, y = cases, fill = result_by_state$death))+
    geom_bar(position="dodge",stat="identity") + 
    ggtitle("Number of Cases by State") +
    xlab("State") +
    ylab("Number of Cases")+
    theme_bw() +
    theme(axis.text.x=element_text(size=rel(0.5), angle=90))
  )

