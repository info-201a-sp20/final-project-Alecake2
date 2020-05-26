library("tidyverse")
library("scales")
library("gridExtra")
library("ggthemes")
library("dplyr")
library("plotly")
library("rbokeh")

covid_cases <- read.csv("data/cleaned_data.csv",
                        stringsAsFactors = FALSE)

df <- covid_cases %>%
  select(date, cases, deaths) %>%
  group_by(date) %>%
  summarise(
    deaths = sum(deaths, na.rm = TRUE),
    cases = sum(cases, na.rm = TRUE),
    death_rate = round(deaths / cases * 100, 2)
  )


plot_one <- ggplotly(
  ggplot(df, aes(x = date, y = death_rate, group = 1))+
    geom_line() + 
    ggtitle("Death Rate Over Time") +
    xlab("Date") +
    ylab("Death Rate (%)")+
    theme_bw() +
    theme(axis.text.x=element_text(size=rel(0.5), angle=90))
)
