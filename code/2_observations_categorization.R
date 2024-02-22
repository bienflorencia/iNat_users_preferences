# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)

species_list <- read.csv("data/species_list.csv")


# GROUPS SELECTION -------------------------------------------------------------

## We are going to create two lists with all the species observed within 
## the most recorded groups: tetrapods and dicotyledons

animals <- species_list %>% 
  filter(taxon_class_name == "Aves" | taxon_class_name == "Amphibia" | 
           taxon_class_name == "Mammalia" | taxon_class_name == "Reptilia")

write.csv(animals,"data/tetrapods_list.csv")


plants <- species_list %>% 
  filter(taxon_family_name == "Fabaceae" | taxon_family_name == "Cactaceae" | 
           taxon_family_name == "Asteraceae"|taxon_family_name == "Solanaceae")

write.csv(plants,"data.csv")