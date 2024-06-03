# dicotiledoneas
library(tidyverse)

old_list <- read_csv('../TesisNaturalistaUY/datos/Tablas/Lista_Plantas_Final.csv')
plantas_na <- read_csv('data/NA_records_plants.csv') %>% janitor::clean_names()
new_list <- read_csv('data/dico_list.csv')


plants_list <- left_join(new_list, 
          old_list %>% 
            select(taxon_species_name, species, 
                   taxon_genus_name, Distribution,
                   Habito1, Habito2, SNAPregional, 
                   BiodiversidataEstablecimiento, 
                   IUCNglobal, trendGlobal), 
          by='taxon_species_name')

plants_list <- left_join(plants_list,
                         plantas_na %>% 
                           rename(taxon_species_name=especie)) 

write_excel_csv(plants_list, 'data/dico_list_updated.csv')

########

# check if there is a synonym
old_list %>% filter(grepl('parodia', species, ignore.case = T))

########

updated_plant_list <- read_csv('data/dico_list_updated.csv')
write_excel_csv(updated_plant_list, 'data/dico_list_updated.csv', na = '')

#####
updated_plant_list %>% filter(!is.na(species)) %>% nrow()
updated_plant_list %>% filter(remarks == 'new species') %>% nrow()
updated_plant_list %>% filter(!is.na(synonym)) %>% nrow()
updated_plant_list %>% filter(!is.na(species) & !is.na(esta_en_powo)) %>% nrow()

