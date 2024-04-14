# PACKAGES & DATA --------------------------------------------------------------

library(rgbif)
library(tidyverse)
library(taxize)

# DATA DOWNLOAD ---------------------------------------------------------------- 

## GBIF Credentials (from gbif.org)
GBIF_USER <- '' # your gbif.org username 
GBIF_PWD <- '' # your gbif.org password
GBIF_EMAIL <- '' # your email 

## GBIF key for iNaturalist's dataset
iNat_KEY <- dataset_search(query='iNaturalist')$data %>% 
  filter(title == 'iNaturalist Research-grade Observations') %>%
  pull(datasetKey)

###iNat_KEY <- "50c9509d-22c7-4a22-a47d-8c48425ef4a7"

## GBIF keys for the studied taxa 

get_TAXON_KEY <- function(taxonList) {
  species_TAXON_KEY <- tibble(taxon=character(),
                              TAXON_KEY = numeric())
  for(taxon in taxonList){
    TAXON_KEY <- get_gbifid_(taxon) %>% 
      bind_rows() %>%
      filter(matchtype == 'EXACT' & status == 'ACCEPTED') %>%
      pull(usagekey)
    if(length(TAXON_KEY)!=0){
      species_TAXON_KEY_i <- tibble(taxon=taxon,
                                    TAXON_KEY = TAXON_KEY)
      species_TAXON_KEY <- rbind(species_TAXON_KEY, species_TAXON_KEY_i)
    } 
  }
  return(species_TAXON_KEY)
}

# get_TAXON_KEY is a function that gets a list of taxa as input 
# and returns a data frame with the taxa and their taxon keys from GBIF 
# (these taxon keys will be used to )

taxa <- c('Aves', 'Mammalia', 'Squamata' , 'Amphibia',
          'Asteraceae', 'Fabaceae', 'Cactaceae', 'Solanaceae')

GBIFtaxonKeys <- get_TAXON_KEY(taxa)

#   taxon      TAXON_KEY
# 1 Aves             212
# 2 Mammalia         359
# 3 Amphibia         131
# 4 Asteraceae      3065
# 5 Fabaceae        5386
# 6 Cactaceae       2519
# 7 Solanaceae      7717

# EXPLORATION ------------------------------------------------------------------

## Data on iNat for Uruguay
occ_count(datasetKey=iNat_KEY,
          country='UY')

# 62612


# GENERATE DATA DOWNLOAD--------------------------------------------------------

occ_download(pred_in('taxonKey', GBIFtaxonKeys$TAXON_KEY),
             pred('datasetKey', iNat_KEY),
             pred('country', 'UY'),
             format='SIMPLE_CSV',
             user=GBIF_USER, pwd=GBIF_PWD, email=GBIF_EMAIL)

# <<gbif download>>
# Your download is being processed by GBIF:
#   https://www.gbif.org/occurrence/download/0149540-240321170329656
# Most downloads finish within 15 min.
# Check status with
# occ_download_wait('0149540-240321170329656')
# After it finishes, use
# d <- occ_download_get('0149540-240321170329656') %>%
#   occ_download_import()
# to retrieve your download.
# Download Info:
#   Username: montielrodrigo0
# E-mail: montielrodrigo0@gmail.com
# Format: SIMPLE_CSV
# Download key: 0149540-240321170329656
# Created: 2024-04-12T12:54:00.691+00:00
# Citation Info:  
#   Please always cite the download DOI when using this data.
# https://www.gbif.org/citation-guidelines
# DOI: 10.15468/dl.3df2fp
# Citation:
#   GBIF Occurrence Download https://doi.org/10.15468/dl.3df2fp 
# Accessed from R via rgbif (https://github.com/ropensci/rgbif) on 2024-04-12


### Check the status
occ_download_wait('0149540-240321170329656')

### Download the data
GBIF_iNat_data <- occ_download_get('0149540-240321170329656') %>%
  occ_download_import()
