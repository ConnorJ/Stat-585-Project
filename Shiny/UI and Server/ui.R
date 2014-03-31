library(shiny)



inputData = grad.merge
College = c( "All", levels(unique(inputData$College)))

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Continuing the Adventure"),
  h5('Companies hiring in this area'),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
      selectInput("College", "Choose a College", choices = College, selected= "All"),
      selectInput("Major", "Choose a Major", choices = NULL, selected="All" ),
      
      ('Choose Years to Include:'),
      checkboxInput("y12", "2011-12", TRUE),
      checkboxInput("y11", "2010-11", TRUE),
      checkboxInput("y10", "2009-10", TRUE),
      checkboxInput("y09", "2008-09", TRUE),
      checkboxInput("y08", "2007-08", TRUE)
      
      
      
      
      
    ),
    
    
    mainPanel(  tableOutput("people1")
                
    )
  )
))



