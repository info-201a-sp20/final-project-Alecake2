# Set up
library("tidyverse")
library("plotly")

covid_cases <- read.csv("data/cleaned_data.csv",
                        stringsAsFactors = FALSE)

death_and_smoking_rate <- covid_cases %>%
  select(county, state, cases, deaths, percent_smokers, total_population) %>%
  mutate(num_smokers = round(percent_smokers * total_population / 100)) %>%
  group_by(county) %>%
  summarise(cases = max(cases, na.rm = FALSE),
            state = max(state),
            deaths = max(deaths, na.rm = FALSE),
            smokers = max(num_smokers),
            total_population = max(total_population)
            ) %>%
  group_by(state) %>%
  summarise(
    death_percentage = sum(deaths) / sum(cases) * 100,
    smoker_percentage = sum(smokers) / sum(total_population) * 100
  )

create_scatter_plot <- function(df) {
  plot_ly(
    data = df,
    y = ~death_percentage,
    x = ~smoker_percentage,
    type = "scatter",
    mode = "markers",
    text = ~state
  ) %>%
  layout(title = "Smoking Population And Death Rate",
         yaxis = list(title = "Death Rate (%)",
                    zeroline = TRUE,
                      range = c(0, 10)
                    ),
         xaxis = list(title = "Smoking Population (%)",
                      range = c(10, 25)
                      )
         )
}

plot_three <- create_scatter_plot(death_and_smoking_rate)