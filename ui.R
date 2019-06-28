# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.

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

ui <- dashboardPage(skin = "red",
                    title = "Google Location Map",
                    dashboardHeader(title = "Google Location Map", titleWidth = 300),
                    
                    # interactive sidebar with menu and widgets
                    dashboardSidebar(width = 300,
                                     
                                  #   tags$div(
                                  #     tags$blockquote("Use this app to load locations (lat/long columns in excel)"),
                                  #     style = "padding: 10px;"
                                       
                                  #   ),
                                     
                                  #   tags$hr(),
                                     
                                  #   # Input: Select a file ----
                                  #   fileInput("file1", "Upload Locations",
                                  #             multiple = FALSE,
                                  #             accept = ".xlsx",
                                  #             placeholder = "Max file size 100Mb"),
                                     
                                  #   tags$hr(),
                                     
                                     selectInput(inputId="Month", label="Month", 
                                                 choices = list("January"="January","February"="February","March"="March",
                                                                "April"="April","May"="May","June"="June","July"="July",
                                                                "August"="August","September"="September","October"="October",
                                                                "November"="November","December"="December")),
                                     
                                     selectInput(inputId="Car", label="Car type", 
                                                 choices = list("New"="New","Used"="Used")),
                                     
                                     tags$div(
                                       p("Select month, select car type, and then zoom in and out."),
                                      # tags$i("Your data will not be stored permamently by this application!"),
                                       style = "padding: 10px;"
                                     )
                                     
                    ),
                    
                    # Main panel for displaying outputs ----
                    dashboardBody(
                      
                      tags$head(tags$style("#myMap{height:90vh !important;}")),
                      
                      leafletOutput("myMap")
                      
                    )
)
