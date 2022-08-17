# nyc_airbnb_map
Beta version, trying to learn leaflet for Shiny

Check live version on shiny server:
https://wpiela.shinyapps.io/nyc_airbnb_map/

or run directly on your desktop:

```
if(!require(c("shiny","tidyverse","leaflet","htmltools","shinyWidgets"))) {
  
  install.packages(c("shiny","tidyverse","leaflet","htmltools","shinyWidgets"))
  
}
shiny::runGitHub(repo="geo_app", username="wiktorpiela", ref="main")
```
