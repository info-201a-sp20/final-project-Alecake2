# Set up
library("tidyverse")
library("plotly")

# Load the data needed for creating the chart.
covid_cases <- read.csv("data/cleaned_data.csv",
                        stringsAsFactors = FALSE)

# Create a dataframe that contains name, smoking population percetage,
# and covid-19 death rate of each state in the U.S.
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

# This function takes in a dataframe and create a scatter plot
# with smoking population percentage on the x axis and covid-19
# death rate on the y axis. Upon hovering on each scatter, the
# popup will show the name, covid 19 death rate, and smoking
# population rate of the corresponding state.
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

# Create the scatter plot by using the dataframe oranized
# previously.
plot_three <- create_scatter_plot(death_and_smoking_rate)