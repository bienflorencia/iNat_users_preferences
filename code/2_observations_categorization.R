# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)


species_list <- read.csv("data/species_list.csv")


# NATUY OBSERVATIONS (WITH RESEARCH GRADE) -------------------------------------

## Users quantity
species_list %>%
  group_by(recordedBy) %>% 
  count() %>% nrow()

### 854

## Number of observed species
species_list %>%
  group_by(species) %>% 
  count() %>% arrange(desc(n)) %>% nrow()

### 1105


## observations by Kingdom
species_list %>%
  group_by(kingdom) %>% 
  summarise("Number of observations"= n(),
            "Number of species" = length(unique(species)))


# GROUPS SELECTION -------------------------------------------------------------

animals <- species_list %>% 
  filter(class == "Aves" | class == "Amphibia" | class == "Mammalia" | 
           class == "Reptilia") %>% group_by(class, species) %>% count()

write.csv(animals,"data/animals_list.csv")


plants <- species_list %>% 
  filter(family == "Fabaceae" | family == "Cactaceae" | 
           family == "Asteraceae"| family == "Solanaceae") %>% 
  group_by(family, species) %>% count()

write.csv(plants,"data/plants_list.csv")
