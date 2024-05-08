library(lubridate)
library(httr)
library(jsonlite)
library(tidyverse)

NatUY_data <- read_csv('data/NatUY_observations_03-05.csv')
users_dataset <- NatUY_data %>% distinct(user_login)

## Function using iNAT API https://api.inaturalist.org/v1/docs/
getObserversNumObservations <- function(user_login_list, 
                                        place_id=7259){
  
  observers_num_observations <- tibble(user_id = numeric(), 
                                       observations_iNat = numeric(), 
                                       observations_NatUY = numeric(),
                                       species_iNat = numeric(), 
                                       species_NatUY = numeric(), 
                                       user_login = character(),
                                       user_created_at = lubridate::ymd_hms(), 
                                       user_name = character())
  num_results <- 1
  for (user_login in user_login_list) {
    if ((num_results %% 10) + 10 == 10) { 
      Sys.sleep(10) # The API needs a delay because otherwise it gives an error. 
      # Every 10 users, the code stops for 10 second
    }
    call <- str_glue('https://api.inaturalist.org/v1/observations/observers', 
                     '?user_login={user_login}&',
                     'place_id={place_id}')
    
    get_json_call <- GET(url = call) %>%
      content(as = "text") %>%
      fromJSON(flatten = TRUE)
    
    if(!'error' %in% names(get_json_call)) {
      results <- as_tibble(get_json_call$results) 
      observer_num_observations <- tibble(user_id = results$user_id, 
                                          observations_iNat = results$user.observations_count,
                                          observations_NatUY = results$observation_count, 
                                          species_iNat = results$user.species_count,
                                          species_NatUY = results$species_count,
                                          user_login = results$user.login,
                                          user_created_at = results$user.created_at, 
                                          user_name = results$user.name)
      observers_num_observations <- rbind(observers_num_observations,
                                          observer_num_observations)
      cat(num_results, 'user:', user_login, ',',
          observer_num_observations$observations_iNat, 'observations on iNat', '\n')
    }
    else {
      observer_num_observations <- tibble(user_id = NA, 
                                          observations_iNat = NA, 
                                          observations_NatUY = NA,
                                          species_iNat = NA, 
                                          species_NatUY = NA, 
                                          user_login = user_login,
                                          user_created_at = NA, 
                                          user_name = NA)
      observers_num_observations <- rbind(observers_num_observations,
                                          observer_num_observations)
      cat('user:', user_login, '--> NOT FOUND', '\n')
    }
    num_results <- nrow(observers_num_observations) + 1
  }
  return(observers_num_observations)
}

observers_num_observations <- getObserversNumObservations(users_dataset$user_login)



##### prueba de usuarios

usuarios_ejemplo <- c('flo_grattarola',
                      'santiagomailhos',
                      'klaus16',
                      'julian_tocce',
                      'cameronr')

getObserversNumObservations(usuarios_ejemplo) %>% 
  mutate(proportion_natuy_inat = round(observations_NatUY*100/observations_iNat, 3),
         uruguayan = ifelse(proportion_natuy_inat>30 , 'yes', 'no'))