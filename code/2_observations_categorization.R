# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)


species_list <- read.csv("data/species_list.csv")


# NATUY OBSERVATIONS (WITH RESEARCH GRADE) -------------------------------------

## Users quantity
species_list %>%
  group_by(user_id) %>% 
  count() %>% nrow()

## Number of observed species
species_list %>%
  group_by(taxon_species_name) %>% 
  count() %>% arrange(desc(n)) %>% nrow()


## observations by Kingdom
kingdom_obs <- species_list %>%
  group_by(taxon_kingdom_name) %>% 
  summarise("Number of observations"= n(),
            "Number of species" = length(unique(taxon_species_name)))

## observations by Class
class_obs <- species_list %>%
  group_by(taxon_class_name) %>% 
  summarise("Number of observations"= n(),
            "Number of species" = length(unique(taxon_species_name)))


# GROUPS SELECTION -------------------------------------------------------------

## We are going to create two lists with all the species observed within 
## the most recorded groups: tetrapods and dicotyledons

animals <- species_list %>% 
  filter(taxon_class_name == "Aves" | taxon_class_name == "Amphibia" | 
           taxon_class_name == "Mammalia" | taxon_class_name == "Reptilia")

write.csv(animals,"data/animals_list.csv")


plants <- species_list %>% 
  filter(taxon_family_name == "Fabaceae" | taxon_family_name == "Cactaceae" | 
           taxon_family_name == "Asteraceae"|taxon_family_name == "Solanaceae")

write.csv(plants,"data/plants_list.csv")