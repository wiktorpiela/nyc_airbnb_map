library("shiny")
library("tidyverse")
library("leaflet")
library("htmltools")
source("ui.R")

# server <- function(input, output, session){
#   
#   nyc <- reactive({
# 
#     if(input$visited==TRUE) filter(read_rds("data/nyc_prepared_data.rds"),reviews_per_month>=2.8) %>% select(-c(id,host_id))
# 
#     else read_rds("data/nyc_prepared_data.rds") %>% select(-c(id,host_id))
# 
#     })
#   
#   output$numeric <- renderText(paste("Locations found:",nrow(nyc_points3())))
#   
#   output$map <- renderLeaflet({
# 
#     leaflet(data = (nyc_points3())) %>%
#         addTiles() %>%
#         addMarkers(lng = ~longitude, lat = ~latitude,
#                    popup = ~paste(htmlEscape(name),"<br>",
#                                   paste("host name:",htmlEscape(host_name),"<br>"),
#                                   paste0("price: ",htmlEscape(price),"$")),
#                    popupOptions = popupOptions(autoClose = TRUE, closeOnClick = TRUE, closeButton = FALSE)) %>%
#         setView(lng = -74.047790, lat = 40.666093, zoom = 12)
# 
# 
#   })
#   
#   nyc_points1 <- reactive({
#     
#     filter(nyc(),neighbourhood_group%in%input$neighbourhood_group)
# 
#   })
#   
#   nyc_points2 <- reactive({
#     
#     filter(nyc_points1(),
#            neighbourhood%in%input$district)
#     
#   })
#   
#   nyc_points3 <- reactive({
#     
#     filter(nyc_points2(),
#            neighbourhood%in%input$district,
#            price >= min(input$price_min) & price <= max(input$price_max),
#            room_type%in%input$room_type)
#     
#   })
#   
#   
#   observeEvent(nyc_points1(),
#                updateSelectInput(inputId = "district",
#                                  choices = sort(unique(nyc_points1()$neighbourhood)))
#   )
#   
# }


server <- function(input, output, session){
  
  nyc <- reactive(read_rds("data/nyc_prepared_data.rds") %>% select(-c(id,host_id)))
  
  output$numeric <- renderText(paste("Locations found:",nrow(nyc_points3())))
  
  output$map <- renderLeaflet({
    
    leaflet(data = (nyc_points3())) %>%
      addTiles() %>%
      addMarkers(lng = ~longitude, lat = ~latitude,
                 popup = ~paste(htmlEscape(name),"<br>",
                                paste("host name:",htmlEscape(host_name),"<br>"),
                                paste0("price: ",htmlEscape(price),"$")),
                 popupOptions = popupOptions(autoClose = TRUE, closeOnClick = TRUE, closeButton = FALSE)) %>%
      setView(lng = -74.047790, lat = 40.666093, zoom = 12)
    
    
  })
  
  nyc_points1 <- reactive({
    
    filter(nyc(),neighbourhood_group%in%input$neighbourhood_group)
    
  })
  
  nyc_points2 <- reactive({
    
    filter(nyc_points1(),neighbourhood%in%input$district)
    
  })
  
  nyc_points2_5 <- reactive({
    
    filter(nyc_points2(),room_type%in%input$room_type)
    
  })
  
  nyc_points3 <- reactive({
    
    if(input$visited==TRUE){
      
      filter(nyc_points2_5(),
             price >= min(input$price_min) & price <= max(input$price_max),
             reviews_per_month>=2.8)
      
    } else {
        
      filter(nyc_points2_5(),
             price >= min(input$price_min) & price <= max(input$price_max))
      }
    })
  
  
  observeEvent(nyc_points1(),
               updateSelectInput(inputId = "district",
                                 choices = sort(unique(nyc_points1()$neighbourhood)))
  )
  
  observeEvent(nyc_points2(),
               updateSelectInput(inputId = "room_type",
                                 choices = sort(unique(nyc_points2()$room_type)))
  )
  
  observeEvent(nyc_points2_5(),{
    
    req(nyc_points2_5())
    updateNumericInput(inputId = "price_min",
                       value = min(nyc_points2_5()$price))
    })
  
  observeEvent(nyc_points2_5(),{
    
    req(nyc_points2_5())
    updateNumericInput(inputId = "price_max",
                       value = max(nyc_points2_5()$price))
    
    })
  
  
}