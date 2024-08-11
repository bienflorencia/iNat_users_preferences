# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(lubridate)

natuy_data <- read_csv("data/natuy_data.csv")
users_dataset <- read_csv("data/users_dataset.csv")
dico_traits <- read_csv("data/dico_traits.csv")
tetra_traits <- read_csv("data/tetra_traits.csv")


# TABLAS------------------------------------------------------------------------

tetra_data <- left_join(natuy_data, 
                        tetra_traits %>% filter(!grepl('Casual', remarks))) %>% 
  filter(!is.na(Distribution)) %>% 
  left_join(., users_dataset %>% select(user_login,user_category))

dico_data <- left_join(natuy_data,
                        dico_traits %>% 
                         filter(!grepl('native', remarks))) %>%
  filter(!is.na(Distribution.x)) %>% 
  left_join(., users_dataset %>% select(user_login,user_category))


write_csv(tetra_data, "data/tetra_data.csv")
write_csv(dico_data, "data/dico_data.csv")