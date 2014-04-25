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
DegreeLevel = c( "All", levels(unique(inputData$Degree.Level)))


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
  titlePanel("Continuing The Adventure After Iowa State"),
  hr(),
  
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
      selectInput("College", "Choose a College", choices = College, selected= "All"),
      selectInput("Major", "Choose a Major", choices = NULL, selected="All" ),
      selectInput("DegreeLevel", "Degree Level", choices = DegreeLevel, selected="All" ),
      selectInput("WorkType", "Type of Position", choices = WorkType, selected="All" ),
      hr(),
      sliderInput("radius", "Choose Circle Radius:", min=0, max=10, value=5),
      hr(),
      h5("Top Employers in this Area"),
      tableOutput("companies1"),
      hr(),
      h5("Salaries in this Area"),
      plotOutput("plot1")
      
      
    ),
    
    
    mainPanel( 
      h4('Companies Hiring in this Area'),
      dataTableOutput("people1")                
    )
  )
))
