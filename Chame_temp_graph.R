library(readxl)
Chame <- read_excel("Climate_complete_seperated.xlsx", sheet = "Chame")

library(ggplot2)
library(tidyverse)
library(dplyr)
 
library(ggpmisc)

chame <- data.frame(x= Chame$Date, y= c(Chame$tmax, Chame$tmin),
               group = c(rep("tmax", nrow(Chame)),
                         rep("tmin", nrow(Chame))))

chame %>%
  ggplot(aes(x,y, color=group, na.rm=T))+
  geom_line()+
  theme_bw()+
  geom_smooth(method="lm", se=T)+
  scale_color_discrete(name='Temperature', labels=c('Maximum','Minimum'))+
  labs(title="Temperature in Chame", size=10,x= "Date", y="Temperature(oC)")+
  facet_wrap(~group, ncol=1,labeller = labeller(group = 
                                                  c("tmax" = "Maximum Temperature",
                                                    "tmin" = "Minimum Temperature")))
ggsave("Chame_temp_lm.jpg", width=9, height=5)
