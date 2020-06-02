library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
source("vis_2.R")
source("interactive_map.R")
server <- function(input, output) {
  
  # Show the map
  output$map <- renderLeaflet({
    map <- build_map(input$plot_date)
    return(map)
  })
  
  output$page2 <- renderPlotly({
    df <- most_cases_covid_19 %>%
      filter(Sex == input$gender)
    plot <- ggplot(data = df) +
      geom_col(mapping = aes_string(
        x = "Age.group",
        y = "COVID.19.Deaths"
      )) +
      theme(axis.text.x = element_text(
        angle = 90, hjust = 1
      )) +
      labs(
        title = "COVID_19 deaths per age group",
        x = "Age Group",
        y = "COVID_19 deaths"
      )
    return(plot)
  })
}

