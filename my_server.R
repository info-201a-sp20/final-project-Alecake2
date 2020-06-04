library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("tidyverse")

source("vis_2.R")
source("vis_1.R")
source("vis_3.R")

# Add variable for server
server <- function(input, output) {
  # output the first page map
  output$map <- renderLeaflet({
    map <- build_map(input$plot_date)
    return(map)
  })
  # output the second page plot
  output$page2 <- renderPlotly({
    df <- most_cases_covid_19 %>%
      filter(Sex == input$gender)
    plot <- ggplot(data = df) +
      geom_col(mapping = aes_string(
        x = "Age.group",
        y = "COVID.19.Deaths",
        fill = "Age.group"
      )) +
      theme(axis.text.x = element_text(
        angle = 90, hjust = 1
      )) +
      theme(legend.position = "none") +
      labs(
        title = "COVID-19 deaths per Age Group",
        x = "Age Group",
        y = "Number of deaths"
      )
    return(plot)
  })
  # output the charts for page three
  output$vis_three <- renderPlotly({
    habit <- input$habit
    v_three_data <- covid_county %>%
      mutate(death_rate = deaths / cases * 100) %>%
      rename(Smoking = percent_smokers, 
             Obesity = percent_adults_with_obesity, 
             Drinking = percent_excessive_drinking, 
             Inactive = percent_physically_inactive, 
             Lack_Sleep = percent_insufficient_sleep) %>%
      rename(wanted_habit = habit) %>%
      select(county, death_rate, wanted_habit) %>%
      group_by(county) %>%
      summarise(death_rate = max(death_rate),
                habit = max(wanted_habit)
      )
     
    plot <- plot_ly(v_three_data, x = ~death_rate, 
                    y = ~habit, text = ~county) %>%
      layout(title = "Habit and Death Rate",
             xaxis = list(title = "Covid-19 Death Rate (%)"), 
             yaxis = list(title = paste(habit, "Percentage")))
    
    
    return(plot)
  })
}
