# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(sf)
sf::sf_use_s2(FALSE)


GBIF_iNat_data <- read_tsv("data/GBIF_iNat_data.csv")


# FILTERING OBSERVACIONS -------------------------------------------------------

species_list <- GBIF_iNat_data %>% st_drop_geometry() %>% 
  select(recordedBy, stateProvince, taxonRank, kingdom, phylum, class,
         order, family, genus, species) %>% 
  filter(taxonRank == "SPECIES")

write.csv(species_list,"data/species_list.csv")
