library(readxl)
Jomsom <- read_excel("Climate_complete_seperated.xlsx", sheet = "Jomsom")

library(ggplot2)
library(tidyverse)
library(dplyr)
library(ggpmisc)

library(ggpubr)
jomsom <- data.frame(x= Jomsom$Date, y= c(Jomsom$tmax, Jomsom$tmin),
                    group = c(rep("tmax", nrow(Jomsom)),
                              rep("tmin", nrow(Jomsom))))

jomsom %>%
  ggplot(aes(x,y, color=group, na.rm=T))+
  geom_line()+
  theme_bw()+
  geom_smooth(method="lm", se=T)+
  scale_color_discrete(name='Temperature', labels=c('Maximum','Minimum'))+
  labs(title="Temperature in Jomsom", size=10,x= "Date", y="Temperature(oC)")+
  facet_wrap(~group, ncol=1,labeller = labeller(group = 
                                                  c("tmax" = "Maximum Temperature",
                                                    "tmin" = "Minimum Temperature")))


ggsave("Jomsom_temp_lm.jpg", width=9, height=5)
