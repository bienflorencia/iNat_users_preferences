# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(sf)
sf::sf_use_s2(FALSE)


observations <- read_csv('data/observations_21-02-24.csv')


# FILTERING OBSERVACIONS -------------------------------------------------------

species_list <- observations %>% st_drop_geometry() %>% 
  select(observed_on, place_admin1_name, taxon_kingdom_name, taxon_phylum_name, 
         taxon_class_name,taxon_order_name, taxon_family_name, 
         taxon_genus_name,taxon_species_name, taxon_subspecies_name) %>% 
  filter(!is.na(taxon_species_name) & taxon_species_name!="") %>%  
  filter(str_count(taxon_species_name, "\\S+") == 2) # This allows us to select 
                                                     # those records that have  
                                                     # two words in the 
                                                     # species_name field

write.csv(species_list,"data/species_list.csv")



