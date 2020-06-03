library("ggplot2")
library("dplyr")

create_plot <- function(df, habbit) {
  df <- df %>%
    mutate(death_rate = deaths / cases * 100) %>%
    rename(wanted_habbit = habbit) %>%
    select(county, death_rate, wanted_habbit) %>%
    group_by(county) %>%
    summarise(death_rate = max(death_rate),
              habbit = max(wanted_habbit)
    )
  plot <- ggplot(df, aes(x = death_rate, y = habbit)) +
    geom_point(alpha = 0.3)
  return(plot)
  
}