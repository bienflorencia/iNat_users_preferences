# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)


natuy_data <- read_csv("data/natuy_data.csv")


# NATUY OBSERVATIONS (WITH RESEARCH GRADE) -------------------------------------

## Number of observed species
natuy_data %>% group_by(taxon_species_name) %>% 
  filter(quality_grade == "research") %>% 
  filter(str_count(taxon_species_name, "\\S+") == 2) %>% 
  count() %>% arrange(desc(n)) %>% nrow()

### 4159

## Users quantity
natuy_data %>%
  group_by(user_login) %>% 
  count() %>% nrow()

### 2146


## Top 10 Clases
natuy_data %>% filter(quality_grade == "research") %>%  
  group_by(taxon_kingdom_name,taxon_phylum_name, taxon_class_name) %>% 
  count() %>% arrange(desc(n)) %>% head(10)


# GROUPS SELECTION -------------------------------------------------------------

species_list <- natuy_data %>% filter(quality_grade == "research") %>% 
  select(user_login, place_admin1_name, taxon_kingdom_name, taxon_phylum_name, 
         taxon_class_name, taxon_order_name, taxon_family_name,
         taxon_genus_name, taxon_species_name) %>%
  filter(str_count(taxon_species_name, "\\S+") == 2)

# (str_count(scientific_name, "\\S+") ==2) allows us to select 
# those records that have two words in the scientific_name field

write.csv(species_list,"data/species_list.csv")


## Tetrapods
tetra <- species_list %>% 
  filter(taxon_class_name == "Aves" |
           taxon_class_name == "Amphibia" |
           taxon_class_name == "Mammalia" |
           taxon_class_name == "Reptilia") %>% 
  group_by(taxon_class_name, taxon_species_name) %>% 
  count()

write.csv(tetra,"data/tetra_list.csv")

## Dicotyledons
dico <- species_list %>% 
  filter(taxon_family_name == "Fabaceae" | 
           taxon_family_name == "Cactaceae" | 
           taxon_family_name == "Asteraceae"|
           taxon_family_name == "Solanaceae") %>% 
  group_by(taxon_family_name, taxon_species_name) %>% 
  count()

write.csv(dico,"data/dico_list.csv")
