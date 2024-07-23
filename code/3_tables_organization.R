library(tidyverse)
library(lubridate)

# PACKAGES & DATA --------------------------------------------------------------
natuy_data <- read_csv("data/natuy_data.csv")
users_dataset <- read_csv("data/users_dataset.csv")
dico_traits <- read_csv("data/dico_traits.csv")
tetra_traits <- read_csv("data/tetra_traits.csv")


# TABLAS------------------------------------------------------------------------

tetra_data <- left_join(natuy_data, 
                        tetra_traits %>% filter(!grepl('Casual', remarks))) %>% 
  filter(!is.na(Distribution)) %>% 
  left_join(., users_dataset %>% select(user_login,user_category))

dicto_data <-