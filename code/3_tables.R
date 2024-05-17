# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)

dico <- read.csv("data/dico_list.csv")
tetra <- read.csv("data/tetra_list.csv")

# JOINING TABLES----------------------------------------------------------------

# These data tables were used in my thesis and have information 
# about the traits of each species analyzed at the time

plants_thesis <- 
  read_csv("~/GitHub/TesisNaturalistaUY/datos/Tablas/Lista_Plantas_Final.csv")

animals_thesis <- 
  read_csv("~/GitHub/TesisNaturalistaUY/datos/Tablas/Lista_Tetrapodos_Final.csv")

## Let's join them with the new tables for this article

## Dicotyledons
plants_thesis <- plants_thesis %>% 
  select(taxon_family_name, taxon_species_name, 
         Distribution, Habito1, IUCNglobal)

dico_traits <- left_join(dico, plants_thesis)

write.csv(dico_traits,"data/dico_traits.csv")


## Tetrapods
animals_thesis <- animals_thesis %>% 
  select(taxon_class_name, taxon_species_name, 
         Distribution, Size, IUCNglobal)

tetra_traits <- left_join(tetra, animals_thesis)


write.csv(tetra_traits,"data/tetra_traits.csv")

