library(readxl)
Humde <- read_excel("Climate_complete_seperated.xlsx", sheet = "humde")

library(ggplot2)
library(tidyverse)
library(dplyr)
 
library(ggpmisc)

humde <- data.frame(x= Humde$Date, y= c(Humde$tmax, Humde$tmin),
               group = c(rep("tmax", nrow(Humde)),
                         rep("tmin", nrow(Humde))))

humde %>%
  ggplot(aes(x,y, color=group, na.rm=T))+
  geom_line()+
  theme_bw()+
  geom_smooth(method="lm", se=T)+
  scale_color_discrete(name='Temperature', labels=c('Maximum','Minimum'))+
  labs(title="Temperature in Humde", size=10,x= "Date", y="Temperature(oC)")+
  facet_wrap(~group, ncol=1,labeller = labeller(group = 
                                                  c("tmax" = "Maximum Temperature",
                                                    "tmin" = "Minimum Temperature")))

ggsave("Humde_temp_lm.jpg", width=10, height=5)
