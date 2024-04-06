# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)

plants <- read.csv("data/plants_list.csv")
animals <- read.csv("data/animals_list.csv")

# JOINING TABLES----------------------------------------------------------------

## These tables were used in my thesis and have the information on the traits 
## of each species
plants_thesis <- 
  read_csv("~/GitHub/TesisNaturalistaUY/datos/Tablas/Lista_Plantas_Final.csv")

animals_thesis <- 
  read_csv("~/GitHub/TesisNaturalistaUY/datos/Tablas/Lista_Tetrapodos_Final.csv")

## Let's join them with the new tables for this article

plants_thesis <- plants_thesis %>% 
  select(taxon_family_name,taxon_species_name, Distribution, Habito1, IUCNglobal)
animals_thesis <- animals_thesis %>% 
  select(taxon_class_name, taxon_species_name, Distribution, Size, IUCNglobal)

plants_traits <- left_join(plants, plants_thesis)
animals_traits <- left_join(animals, animals_thesis)


write.csv(plants_traits,"data/plants_traits.csv")
write.csv(animals_traits,"data/animals_traits.csv")





