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

#rain in 2017
yr2017 <- yearly_rain %>%
  filter(yr==2017)
head(yr2017)

write.csv(yr2017, file="rainfall_in_2017.csv")

#rainfall graph

yearly_rain$yr <- as.numeric(yearly_rain$yr)
head(yearly_rain)

yearly_rain %>%
  ggplot(aes(yr,year_rain, color=station, na.rm=T))+
  geom_point(size=2)+
  theme_bw()+
  geom_smooth(method="lm", se=F)+
  scale_y_continuous(breaks= c(0,1000,2000,3000,4000,5000,6000))+
  scale_x_continuous(breaks= c(1990,1995,2000,2005,2010,2015,2020))+
  scale_color_discrete(name='Weather Stations')+
  labs(title="Yearly Rainfall", size=10,x= "Year", y="Rainfall (mm)")+
  facet_wrap(~station)

ggsave("yearly_rainfall_facetwrap.jpg", width=9, height=7)
