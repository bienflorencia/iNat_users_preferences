# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(ggplot2)
library(patchwork)
library(RColorBrewer)

dico_data <- read_csv("data/dico_data.csv")
tetra_data <- read_csv("data/tetra_data.csv")
  

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
  scale_fill_brewer(palette = "OrRd", name = 'taxa') + 
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
  scale_fill_brewer(palette = "OrRd") + 
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
  scale_fill_brewer(palette = "OrRd") + 
  theme_bw() 


# conservation status
tetra_plot_status <- tetra_data %>% 
  group_by(user_category, IUCNglobal) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= factor(IUCNglobal,
  levels = c('LC', 'NT', 'VU', 'EN', 'CR', 'DD', 'NE')))) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "IUCNglobal") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "OrRd", name='conservation status') + 
  theme_bw() 

(tetra_plot_group | tetra_plot_distribution) / 
  (tetra_plot_size | tetra_plot_status)


# PLANTS GRAPHS ------------------------------------------------------------

dico_plot_group <- dico_data %>% 
  group_by(user_category,taxon_order_name) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= taxon_order_name)) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T,
           position = "fill") + 
  labs(x="", y="Number of records", fill = "Family") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "Greens", name = '') + 
  theme_bw()

# distribution
dico_plot_distribution <- dico_data %>% 
  group_by(user_category, distribution) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= factor(distribution,
                                     levels = c('narrow', 'medium', 'wide')))) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "distribution") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "Greens") + 
  theme_bw() 

# growth form
dico_plot_growth_form <- dico_data %>%
  mutate(growth_form = factor(growth_form, levels = c('tree', 'shrub', 'vine', 'herb', 'liana', 'subshrub')),
         user_category = factor(user_category, levels = c('beginner', 'intermediate', 'expert'))) %>%
  filter(!is.na(growth_form), !is.na(user_category)) %>%  # Asegura que no haya NA en estas columnas
  group_by(user_category, growth_form) %>%
  count() %>%
  ggplot(aes(x = "", y = n, fill = growth_form)) +
  geom_bar(width = 0.5, stat = "identity", show.legend = TRUE, position = "fill") + 
  labs(x = "", y = "Proportion of records", fill = "growth form") + 
  facet_grid(~ user_category) + 
  scale_fill_brewer(palette = "Greens") + 
  theme_bw()


# conservation status
dico_plot_status <- dico_data %>% 
  group_by(user_category, IUCNglobal) %>% count() %>% 
  ggplot(aes(x="", y=n, fill= factor(IUCNglobal,
                                     levels = c('LC', 'NT', 'VU', 'EN', 'CR', 'DD', 'NE')))) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T, 
           position = "fill") + 
  labs(x="", y="Proportion of records", fill = "IUCNglobal") + 
  facet_grid(~ factor(user_category, 
                      levels = c('beginner', 'intermediate', 'expert'))) + 
  scale_fill_brewer(palette = "Greens", name='conservation status') + 
  theme_bw() 

(dico_plot_group | dico_plot_distribution) / 
  (dico_plot_growth_form | dico_plot_status)

