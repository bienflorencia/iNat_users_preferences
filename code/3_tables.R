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

###Plants
plants_thesis <- plants_thesis %>% 
  select(family = taxon_family_name, species= taxon_species_name, 
         Distribution, Habito1, IUCNglobal)

plants_traits <- left_join(plants, plants_thesis)

write.csv(plants_traits,"data/plants_traits.csv")


###Animals
animals_thesis <- animals_thesis %>% 
  select(class = taxon_class_name, species= taxon_species_name, 
         Distribution, Size, IUCNglobal)

animals_traits <- left_join(animals, animals_thesis)


write.csv(animals_traits,"data/animals_traits.csv")

