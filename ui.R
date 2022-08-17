library("shiny")
library("leaflet")
library("shinyWidgets")
library("tidyverse")

nyc <- read_rds("data/nyc_prepared_data.rds")

ui <- fluidPage(
  
  tags$head(includeCSS("www/map_style.css")),
  
  leafletOutput("map", width="100%", height=900),
  
  absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                width = 330, height = "auto",
    br(),
    
    checkboxGroupInput("neighbourhood_group",
                       label = strong("Choose neighbourhood"),
                       choices = sort(unique(nyc$neighbourhood_group)),
                       selected = sort(unique(nyc$neighbourhood_group))[3]),
    
    selectizeInput("district",
                   label = strong("Select district"),
                   choices = NULL,
                   multiple = TRUE,
                   size = 5),
    
    selectInput("room_type",
                label = strong("Choose room's type"),
                choices = NULL,
                multiple = TRUE),
    
    fluidRow(
      
      column(6, 
             align="right",
             numericInput("price_min",
                          label = "Min price",
                          value = NULL,
                          width="100px")
             ),
      
      column(6,
             align="left",
             numericInput("price_max",
                          label = "Max price",
                          value = NULL,
                          width="100px")
             )
      ),
    
    fluidRow(column(12,
                    align = "center",
                    switchInput("visited",
                                "Only most visited",
                                onLabel = "YES",
                                offLabel = "NO",
                                labelWidth = "200px"))),
    
    # fluidRow(column(12,
    #                 align="center",
    #                 actionButton("run", "Run",
    #                              width = "240px"))),
    
    textOutput("numeric")

    )
)
