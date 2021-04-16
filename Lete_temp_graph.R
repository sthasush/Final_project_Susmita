library(readxl)
Lete <- read_excel("Climate_complete_seperated.xlsx", sheet = "Lete")
Lete$tmin <-as.numeric(Lete$tmin)
Lete$tmax <-as.numeric(Lete$tmax)
Lete$Date <- as.Date(Lete$Date)
View(Lete)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(ggpmisc)
library(ggpubr)
lete <- data.frame(x= Lete$Date, y= c(Lete$tmax, Lete$tmin),
                     group = c(rep("tmax", nrow(Jomsom)),
                               rep("tmin", nrow(Jomsom))))

my.formula= y~ poly(x,2)
formula= y~x

lete %>%
  ggplot(aes(x,y,color=group,na.rm=T))+
  geom_line()+
  scale_x_date(limits=as.Date(c("2000-01-01","2020-01-01")))+
  theme_bw()+
  geom_smooth( method="lm", se=T)+
  scale_color_discrete(name='Temperature', labels=c('Maximum','Minimum'))+
  labs(title="Temperature in Lete", size=10,x= "Date", y="Temperature(oC)")+
  facet_wrap(~group, ncol=1,labeller = labeller(group = 
                                                  c("tmax" = "Maximum Temperature",
                                                    "tmin" = "Minimum Temperature")))

  #stat_regline_equation(formula=formula, aes(label=paste(..eq.label..,..rr.label..,sep='~~~')))
#stat_poly_eq(formula=my.formula,
#aes(label=paste(..eq.label..,..rr.label..,sep='~~~'), size=5))


ggsave("Lete_temp_seperate.jpg", width=10, height=5)
