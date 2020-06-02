#server
library("dplyr")
source("script.R")
covid_county <- read.csv("cleaned_data copy.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  output$vis_three <- renderPlot({
habbit <- input$habbit
    return(create_plot(covid_county, habbit))
  })
}