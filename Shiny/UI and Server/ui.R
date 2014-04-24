library(ShinyDash)
library(shiny)
library(reshape2)
library(plyr)
library(leafletR)
library(leaflet)

inputData = grad.merge
# Put this back for multiple college
#College = c( "All", levels(unique(inputData$College)))
College = c( "All", unique(inputData$College))
WorkType = c( "All", levels(unique(inputData$Work.Type)))

shinyUI(fluidPage(
  
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),
  leafletMap(
    "map", "100%", 400,
    initialTileLayer = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
    initialTileLayerAttribution = HTML('Maps by <a href="http://www.mapbox.com/">Mapbox</a>'),
    options=list(
      center = c(37.45, -93.85),
      zoom = 4,
      maxBounds = list(list(17, -180), list(59, 180))
    )
  ),
  
  
  # Application title
  titlePanel("Continuing the Adventure after Iowa State"),
  hr(),
  
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
      selectInput("College", "Choose a College", choices = College, selected= "All"),
      selectInput("Major", "Choose a Major", choices = NULL, selected="All" ),
      selectInput("WorkType", "Type of Position", choices = WorkType, selected="All" ),
      hr(),
      ('Choose Years to Include:'),
      checkboxInput("y12", "2011-12", TRUE),
      checkboxInput("y11", "2010-11", TRUE),
      checkboxInput("y10", "2009-10", TRUE),
      checkboxInput("y09", "2008-09", TRUE),
      checkboxInput("y08", "2007-08", TRUE),
      hr(),
      sliderInput("radius", "Choose Circle Radius:", min=0, max=10, value=5),
      hr(),
      h5("Top Employers in this Area"),
      tableOutput("companies1"),
      hr(),
      plotOutput("plot1")
      
      
    ),
    
    
    mainPanel( 
      h4('Companies hiring in this area'),
      dataTableOutput("people1")                
    )
  )
))
