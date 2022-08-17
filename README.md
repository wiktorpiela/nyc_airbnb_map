# nyc_airbnb_map
Beta version, trying to learn leaflet for Shiny

Check live version on shiny server:
https://wpiela.shinyapps.io/nyc_airbnb_map/

or run directly on your desktop:
```
list_of_packages <- c("shiny","tidyverse","leaflet","htmltools","shinyWidgets")
new_packages <- list_of_packages[!(list_of_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

shiny::runGitHub(repo="nyc_airbnb_map", username="wiktorpiela", ref="main")
```
