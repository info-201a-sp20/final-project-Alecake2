library("dplyr")
df <- read.csv("data/cleaned_data.csv")
df <- df %>%
  mutate(death_rate = deaths / cases * 100) %>%
  select(county, death_rate) %>%
  group_by(county) %>%
  summarise(death_rate = max(death_rate))

zeros <- nrow(filter(df, death_rate == 0))

hundres <- nrow(filter(df, death_rate == 100))

take_away_3  <- p("Base on the data, we don't see any clear association
between bad habits and covid-19 death rate. The scatter plots for all five
habits(smoking, drinking, physically inactive, and insufficient sleep) appear
randomly distributed. However, we can't firmly conclude that there is no
association between those habits and covid-19 death rate, because the sample
size is relatively small when we use county as individual data point. Also, as
we can see, there are", zeros,"counties with zero percent death rate and", hundres,
"counties with one hundred percent death rate. Those extreme values 
for Covid-19 death could alter the result heaviley")

