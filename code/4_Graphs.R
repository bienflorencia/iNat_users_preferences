# PACKAGES & DATA --------------------------------------------------------------
library(tidyverse)
library(ggplot2)
library(patchwork)
library(RColorBrewer)

dico_data <- read_csv("data/dico_data.csv")
tetra_data <- read_csv("data/tetra_data.csv")


# TETRAPHODS GRAPHS ------------------------------------------------------------

tgroups <- tetra_data %>% 
  group_by(user_category,taxon_class_name) %>% count() %>% 
  ggplot(aes(x="", y=n, fill=taxon_class_name)) +
  geom_bar(width = 0.5, stat = "identity", show.legend = T) + 
  labs(x="", y="Number of records", fill = "Class") + 
  facet_grid(~user_category) + 
  scale_fill_brewer(palette = "YlOrRd") + 
  theme_bw()