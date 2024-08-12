# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(ggplot2)
library(patchwork)
library(RColorBrewer)

dico_data <- read_csv("data/dico_data.csv")
tetra_data <- read_csv("data/tetra_data.csv")


tetra_data <- tetra_data %>% 
  mutate(distribution = case_when(Distribution <= 5 ~ 'narrow',
                                  Distribution > 5 & Distribution <= 16 ~ 'medium',
                                  Distribution > 16 ~ 'wide', 
                                  is.na(Distribution) ~ 'not assessed')) %>%
  mutate(size = case_when(taxon_class_name == 'Mammalia' & 
                            Size < 50 ~ 'small',
                          taxon_class_name == 'Mammalia' & 
                            Size >= 50 & Size < 200 ~ 'medium',
                          taxon_class_name == 'Mammalia' & 
                            Size >= 200 ~ 'large',
                          taxon_class_name == 'Amphibia' & 
                            Size < 5 ~ 'small',
                          taxon_class_name == 'Amphibia' & 
                            Size >= 5 & Size < 10 ~ 'medium',
                          taxon_class_name == 'Amphibia' & 
                            Size >= 10 ~ 'large',
                          taxon_class_name == 'Reptilia' & 
                            Size < 50 ~ 'small',
                          taxon_class_name == 'Reptilia' & 
                            Size >= 50 & Size < 100 ~ 'medium',
                          taxon_class_name == 'Reptilia' & 
                            Size >= 100 ~ 'large',
                          taxon_class_name == 'Aves' & 
                            Size < 20 ~ 'small',
                          taxon_class_name == 'Aves' & 
                            Size >= 20 & Size < 50 ~ 'medium',
                          taxon_class_name == 'Aves' & 
                            Size >= 50 ~ 'large'))
  

# TETRAPODS GRAPHS ------------------------------------------------------------

# group
tetra_plot_group <- tetra_data %>% 
  group_by(user_category,taxon_class_name) %>% count() %>% 
  ggplot(aes(x="", y=n, fill=taxon_class_name)) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "Class") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "BuPu", name = 'taxa') + 
  theme_bw() 

# distribution
tetra_plot_distribution <- tetra_data %>% 
  group_by(user_category, distribution) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= factor(distribution,
                                     levels = c('narrow', 'medium', 'wide')))) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "distribution") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "BuPu") + 
  theme_bw() 

# size
tetra_plot_size <- tetra_data %>% 
  group_by(user_category, size) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= factor(size,
                                     levels = c('small', 'medium', 'large')))) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "size") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "BuPu") + 
  theme_bw() 


# conservation status
tetra_plot_status <- tetra_data %>% 
  group_by(user_category, IUCNglobal) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= factor(IUCNglobal,
  levels = c('LC', 'NT', 'VU', 'EN', 'CR', 'DD', 'NE')))) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "size") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "BuPu", name='conservation status') + 
  theme_bw() 

(tetra_plot_group | tetra_plot_distribution) / (tetra_plot_size | tetra_plot_status)


# PLANTS GRAPHS ------------------------------------------------------------

dico_data %>% 
  group_by(user_category,taxon_order_name) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= taxon_order_name)) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T,
           position = "fill") + 
  labs(x="", y="Number of records", fill = "Class") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "YlOrRd", name = '') + 
  theme_bw()

