# This is the server logic of a Shiny web application. You can run the application by clicking 'Run App' above.
if("shiny" %in% rownames(installed.packages()) == FALSE) { install.packages("shiny")}
if("leaflet" %in% rownames(installed.packages()) == FALSE) { install.packages("leaflet")}
if("tidyverse" %in% rownames(installed.packages()) == FALSE) { install.packages("tidyverse")}
if("lubridate" %in% rownames(installed.packages()) == FALSE) { install.packages("lubridate")}
if("shinydashboard" %in% rownames(installed.packages()) == FALSE) { install.packages("shinydashboard")}
if("readxl" %in% rownames(installed.packages()) == FALSE) { install.packages("readxl")}
library(shiny)
library(leaflet)
library(tidyverse)
library(lubridate)
library(shinydashboard)
library(readxl)

# Define server logic to read selected file ----
server <- function(input, output) {
  
  options(shiny.maxRequestSize = 100*1024^2)
  
  output$myMap <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(providers$CartoDB.Positron, group = "Default Maptile") %>% 
      addTiles() %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "Satellite Maptile") %>%
      setView(24, 27, zoom = 2) %>% 
      addLayersControl(
        baseGroups = c("Default Maptile", "Satellite Maptile"),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
  
  observe({
    
  #  withProgress(#message = 'Please wait...',
                 #value = 0/4, {
                   
                  # req(input$file1)
                   
                  # incProgress(1/4, detail = "reading data")
                   
                  # myData <- read_excel(input$file1$datapath, sheet = 1)
                   myData <- read_excel("Car_City_Maps.xlsx", sheet = 1) 
                   
                  #                     newIcons <- iconList(
                  #  stand = makeIcon("stand.png", "stand.png", 36, 36),
                  #   drive = makeIcon("drive.png", "drive.png", 36, 36)
   #                )
                  
                  # incProgress(1/4, detail = "cleaning data")
                   
                  # incProgress(1/4, detail = "rendering map")
                   
                     reactive_data = reactive({
                        selected_month = input$Month
                        selected_car = input$Car
                        return(myData[(myData$Month==selected_month)&(myData$Car==selected_car),])
                        })
                   
                   leafletProxy("myMap", data = reactive_data()) %>% 
                     fitBounds(~min(longitude), ~min(latitude), ~max(longitude), ~max(latitude)) %>%  
                     addMarkers(data = reactive_data(), ~longitude, ~latitude,
                                labelOptions = labelOptions(noHide = F, direction = 'auto'),
                                options = markerOptions(riseOnHover = TRUE),
                                clusterOptions = markerClusterOptions(),
                                popup = paste(reactive_data()$City, "<br>",
                                             "Cars sold:", reactive_data()$Number, "<br>"
                                             
                                )
                                
                                ) %>% 
                     addLayersControl(
                       baseGroups = c("Default Maptile", "Satellite Maptile"),
                       #overlayGroups = c("Points"),
                       options = layersControlOptions(collapsed = FALSE)
                     )
                   
                    
                     
                  #incProgress(1/4)
                
                 
                  
                 })
#  })
  
}

#https://github.com/rstudio/shiny-examples/blob/master/063-superzip-example/server.R

# Create Shiny app ----
#shinyApp(ui, server)