library(readxl)
rain_all <- read_excel("Climate_complete_seperated.xlsx", 
                       sheet = "rain_all")
library(dplyr)
library(stringr)

str(rain_all)
rain_all$date <-as.Date(rain_all$date)
rain_all$rainfall_sum <- as.numeric(rain_all$rainfall_sum)
str(rain_all)

#monthly total rainfall
rain_all <- rain_all %>%
  mutate(yr_mth= format(date,"%Y-%m"))

?group_by

monthly_rain <- rain_all %>%
  group_by(index_no,station,yr_mth) %>%
  summarize(month_rain= sum(rainfall_sum)) %>%
  arrange(station)


head(monthly_rain)
View(monthly_rain)

write.csv(monthly_rain, file="complete_monthly_rainfall.csv")

# yearly total rainfall
rain_all <- rain_all %>%
  mutate(yr = format (date,"%Y"))

yearly_rain <- rain_all %>%
  group_by(index_no,station, yr) %>%
  summarize(year_rain= sum(rainfall_sum)) %>%
  arrange(station)
head(yearly_rain)
View(yearly_rain)

write.csv(yearly_rain, file="complete_yearly_rainfall.csv")
