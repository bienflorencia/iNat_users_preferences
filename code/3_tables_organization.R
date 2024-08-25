# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(lubridate)

natuy_data <- read_csv("data/natuy_data.csv")
users_dataset <- read_csv("data/users_dataset.csv")
dico_traits <- read_csv("data/dico_traits.csv")
tetra_traits <- read_csv("data/tetra_traits.csv")


# TABLES------------------------------------------------------------------------

## Tetrapods
tetra_data <- left_join(natuy_data, 
                        tetra_traits %>% filter(!grepl('Casual', remarks))) %>% 
  filter(!is.na(Distribution))


tetra_data <- tetra_data %>% 
  mutate(distribution = case_when(Distribution <= 5 ~ 'narrow',
                                  Distribution > 5 & Distribution <= 16 ~ 'medium',
                                  Distribution > 16 ~ 'wide', 
                                  is.na(Distribution) ~ 'not assessed')) %>%
  mutate(size = case_when(taxon_class_name == 'Mammalia' & 
                            Size < 50 ~ 'small',
                          taxon_class_name == 'Mammalia' & 
                            Size >= 50 & Size < 200 ~ 'medium',
                          taxon_class_name == 'Mammalia' & 
                            Size >= 200 ~ 'large',
                          taxon_class_name == 'Amphibia' & 
                            Size < 5 ~ 'small',
                          taxon_class_name == 'Amphibia' & 
                            Size >= 5 & Size < 10 ~ 'medium',
                          taxon_class_name == 'Amphibia' & 
                            Size >= 10 ~ 'large',
                          taxon_class_name == 'Reptilia' & 
                            Size < 50 ~ 'small',
                          taxon_class_name == 'Reptilia' & 
                            Size >= 50 & Size < 100 ~ 'medium',
                          taxon_class_name == 'Reptilia' & 
                            Size >= 100 ~ 'large',
                          taxon_class_name == 'Aves' & 
                            Size < 20 ~ 'small',
                          taxon_class_name == 'Aves' & 
                            Size >= 20 & Size < 50 ~ 'medium',
                          taxon_class_name == 'Aves' & 
                            Size >= 50 ~ 'large'))

write_csv(tetra_data, "data/tetra_data.csv")



## Dicotyledons
dico_data <- left_join(natuy_data,
                        dico_traits %>% 
                         filter(!grepl('native', remarks))) %>%
  filter(!is.na(Distribution))

dico_data <- dico_data %>% 
  mutate(distribution = case_when(Distribution <= 5 ~ 'narrow',
                                  Distribution > 5 & Distribution <= 16 ~ 'medium',
                                  Distribution > 16 ~ 'wide', 
                                  is.na(Distribution) ~ 'not assessed')) %>% 
  rename(growth_form = Habito1)


write_csv(dico_data, "data/dico_data.csv")
