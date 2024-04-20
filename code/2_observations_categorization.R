# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)


GBIF_iNat_data <- read_tsv("data/GBIF_iNat_data.csv")


# NATUY OBSERVATIONS (WITH RESEARCH GRADE) -------------------------------------

## Number of observed species
GBIF_iNat_data %>%
  group_by(species) %>% 
  count() %>% arrange(desc(n)) %>% nrow()

### 3854

## Users quantity
GBIF_iNat_data %>%
  group_by(recordedBy) %>% 
  count() %>% nrow()

### 1236

## observations by Kingdom
GBIF_iNat_data %>%
  group_by(kingdom) %>% 
  summarise("Number of observations"= n(),
            "Number of species" = length(unique(species)))

## Top 10 Clases
Taxon_Clases <- GBIF_iNat_data %>%  
  filter(kingdom=='Animalia') %>% 
  group_by(kingdom, phylum, class) %>% 
  count() %>% arrange(desc(n)) %>% head(20)


# GROUPS SELECTION -------------------------------------------------------------

species_list <- GBIF_iNat_data %>% st_drop_geometry() %>% 
  select(recordedBy, stateProvince, taxonRank, kingdom, phylum, class,
         order, family, genus, species) %>% 
  filter(taxonRank == "SPECIES")

write.csv(species_list,"data/species_list.csv")

## Tetrapods
animals <- species_list %>% 
  filter(class == "Aves" | class == "Amphibia" | class == "Mammalia" | 
           class == "Squamata" | class == "Testudines"| 
           class == "Crocodylia" ) %>% 
  group_by(class, species) %>% count()

write.csv(animals,"data/animals_list.csv")

## Dicotyledons
plants <- species_list %>% 
  filter(family == "Fabaceae" | family == "Cactaceae" | 
           family == "Asteraceae"| family == "Solanaceae") %>% 
  group_by(family, species) %>% count()

write.csv(plants,"data/plants_list.csv")
