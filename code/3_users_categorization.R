# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(sf)
sf::sf_use_s2(FALSE)
library(lubridate)
library(httr)
library(jsonlite)

# USERS CATEGORIZATION ---------------------------------------------------------

users_dataset <- observations %>% st_drop_geometry() %>% 
  select(user_login, observed_on, created_at, user_id) %>% 
  group_by(user_login) %>% 
  summarise(first_record = min(created_at), 
            last_record = max(created_at), 
            observations = n(), activity_time = 
              difftime(last_record,first_record, 
                       units = "days")+1, 
            observations_by_time = observations/as.numeric(activity_time)) %>% 
  mutate(user_category = ifelse(observations>=1000 & activity_time>=365 &
                                  observations_by_time>=0.6, "experienced",
                                    ifelse(observations>=50 & activity_time>90 & 
                                             observations_by_time>0.2,
                                           "intermediate", "beginner")))

# USERS NATIONALITY ------------------------------------------------------------

## Function using iNAT API https://api.inaturalist.org/v1/docs/

get_observers_num_observations <- function(user_login_list){
  observers_num_observations <- tibble(user_id = numeric(), 
                                       observation_count = numeric(), 
                                       species_count = numeric(), 
                                       user_login = character(),
                                       user_created_at = lubridate::ymd_hms(), 
                                       user_name = character())
  num_results <- 1
  for (user_login in user_login_list) {
    if ((num_results %% 10) + 10 == 10) { 
      Sys.sleep(10) # The API needs a delay because otherwise it gives an error. 
                    # Every 10 users, the code stops for 10 second
    }
    call <- paste0("https://api.inaturalist.org/v1/observations/observers?user_login=", user_login)
    get_json_call <- GET(url = call) %>%
      content(as = "text") %>%
      fromJSON(flatten = TRUE)
    if (is.null(get_json_call)) {
      observer_num_observations <- tibble(user_id = NA, 
                                          observation_count = NA, 
                                          species_count = NA, 
                                          user_login = user_login,
                                          user_created_at = NA, 
                                          user_name = NA)
      observers_num_observations <- rbind(observers_num_observations, observer_num_observations)
      cat('user:', user_login, '--> NOT FOUND', '\n')
    }
    else {
      results <- as_tibble(get_json_call$results) 
      observer_num_observations <- tibble(user_id = results$user_id, 
                                          observation_count = results$observation_count, 
                                          species_count = results$species_count, 
                                          user_login = results$user.login,
                                          user_created_at = results$user.created_at, 
                                          user_name = results$user.name)
      
      observers_num_observations <- rbind(observers_num_observations, observer_num_observations)
      cat(num_results, 'user:', user_login, '--> DONE', '\n')
    }
    num_results <- nrow(observers_num_observations) + 1
  }
  return(observers_num_observations)
}


observers_num_observations <- get_observers_num_observations(users_dataset$user_login)


natuy_users <- left_join(as_tibble(users_dataset), 
                         observers_num_observations %>% 
                           mutate(user_name=ifelse(user_name=='', NA, user_name))) %>% 
  mutate(first_record=lubridate::as_datetime(first_record),
         last_record=lubridate::as_datetime(last_record),
         user_created_at=lubridate::as_datetime(user_created_at))


write.csv(natuy_users,'data/natuy_users.csv')


# FILTERING USERS --------------------------------------------------------------

## uruguayans in the data
uruguayans <- natuy_users %>% 
  mutate(proportion_natuy_inat = round(observations*100/observation_count, 3),
         uruguayan = ifelse(proportion_natuy_inat>30 , 'yes', 'no')) %>% 
  filter(uruguayan == "yes") %>% 
  group_by(uruguayan)

users_uy <- filter(users_dataset, user_login %in% uruguayans$user_login)


## foreigners in the data
foreign <- natuy_users %>% 
  mutate(proportion_natuy_inat = round(observations*100/observation_count, 3),
         uruguayan = ifelse(proportion_natuy_inat>30 , 'yes', 'no')) %>% 
  filter(uruguayan == "no") %>% 
  group_by(uruguayan)

users_fn <- filter(usuarios_dataset, user_login %in% foreign$user_login)


write.csv(users_uy, "data/users_uy.csv")
write.csv(users_fn, "data/users_fn.csv")
