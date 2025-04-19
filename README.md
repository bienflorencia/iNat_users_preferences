# Users' preferences on iNat

## Beginners and expert citizen scientists prefer similar species on iNaturalist, but experts contribute on average almost a hundred times more data

*Rodrigo Montiel <a dir="ltr" href="http://orcid.org/0009-0000-3128-5502" target="_blank"><img class="is-rounded" src="https://upload.wikimedia.org/wikipedia/commons/0/06/ORCID_iD.svg" width="15"></a>, Magdalena Carabio, Manuele Bazzichetto <a dir="ltr" href="http://orcid.org/0000-0002-9874-5064" target="_blank"><img class="is-rounded" src="https://upload.wikimedia.org/wikipedia/commons/0/06/ORCID_iD.svg" width="15"></a>, Petr Keil <a dir="ltr" href="http://orcid.org/0000-0003-3017-1858" target="_blank"><img class="is-rounded" src="https://upload.wikimedia.org/wikipedia/commons/0/06/ORCID_iD.svg" width="15"></a> & Florencia Grattarola <a dir="ltr" href="http://orcid.org/0000-0001-8282-5732" target="_blank"><img class="is-rounded" src="https://upload.wikimedia.org/wikipedia/commons/0/06/ORCID_iD.svg" width="15"></a>*

This study aimed to identify users' preferences for visibility, geographic distribution, and conservation status of the species being recorded, according to their level of experience on iNaturalist in Uruguay (NaturalistaUY). This repository (<https://github.com/Rodrigo-Montiel/iNat_users_preferences>) includes the data, code, model and outputs to reproduce our work.


**Explore the manuscript's [Full Methodology](https://bienflorencia.github.io/iNat_users_preferences/code/analyses.html)**. 

![](/figs/Figure_1.png)

### Data

  - `data/NatUY_observations_03-05.csv`: a csv file with the iNaturalist data downloaded on 2024-05-03 (yyyy/mm/dd).  
  - `data/observers_num_observations.csv`: a csv file with the number of records per user_id (1) in the global platform, and (2) in Uruguay, used to calculate foreign users recording in Uruguay.
  - `data/tetra_traits.csv`: a csv file with the list of tetrapod species and their traits values (distribution area, body size, and conservation status) used in the analyses.  
  - `data/dico_traits.csv`: a csv file with the list of plant species and their traits values (distribution area, growth form, and conservation status) used in the analyses.  
  - `data/Uruguay.rds`: an rds file with the sf multipolygon object of Uruguay, with the 19 departments (sub-national administration level).     
  
### Code
  - `code/analyses.qmd`: a quarto file with the code used to analyse the data, and create table summaries and figures.  
  - `code/analyses.html`: an html compiled file with the code used to analyse the data, and create table summaries and figures.  

## Figures
  - `figs/Figure_1.png`: a png figure with the hypothesised relationships between the users' experience on the iNaturalist platform and the traits they record, for tetrapod and plant species.     
  - `figs/Figure_2.png`: a png figure with the hypothesised relationships between the users' experience on the iNaturalist platform and the mean or the standard deviations (SD) of the traits recorded per user, for tetrapod and plant species.   
  - `figs/Figure_3.png`: a png figure with the distribution of the iNaturalist records in Uruguay assessed in this study, for tetrapods and plants separately.  
  - `figs/Figure_4.png`: a png figure with the users' proportion preferences towards recording species of tetrapods, according to their: distribution area,  body size, and conservation status.
  - `figs/Figure_5.png`: a png figure with the users' proportion preferences in recording species of plants, according to their distribution area, growth form, and conservation status.
   - `figs/Figure_S1.png`: a png figure with the geographic coverage of the records by each user category in Uruguay over grid cells of 10 by 10 km size.  
   - `figs/Figure_S2.png`: a png figure with the of records of tetrapods in our dataset per taxonomic class and trait.   
   - `figs/Figure_S3.png`: a png figure with the of records of plants in our dataset per taxonomic class and trait.  

## LICENCE

**Data** are available under the terms of the Creative Commons Attribution 4.0 International licence CC-BY 4.0 (https://creativecommons.org/licenses/by/4.0/legalcode.en).   

**Code** is available under the terms of the GPL-3.0 licence (https://www.gnu.org/licenses/gpl-3.0.html). 

## CITATION

> Montiel R., Carabio M., Bazzichetto M., Keil P., & Grattarola F. (2024) Beginners and expert citizen scientists prefer similar species on iNaturalist, but experts contribute on average almost a hundred times more data.
