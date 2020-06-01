library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")

covid_deaths <-
  read.csv("data/Provisional_COVID-19_Death_Counts_by_Sex__Age__and_State.csv",
           stringsAsFactors = FALSE, encoding = "UTF-8"
  )
most_cases_covid_19 <- covid_deaths %>%
  filter(State == "United States") 


  
# Second Visualization
server2 <- function(input, output) {
  output$plot_no2 <- renderPlotly({
    df <- most_cases_covid_19 %>%
      filter(Sex == input$gender)
    plot <- ggplot(data = df) +
      geom_col(mapping = aes_string(
        x = "Age.group",
        y = "COVID.19.DEATHS"
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