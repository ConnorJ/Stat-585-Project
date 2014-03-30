library(shiny)


inputData = grad.merge


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {
  College = unique(inputData$College)
  
  observe({
    Major = unique(subset(inputData, College == input$College)$Major)
    updateSelectInput(session, "Major", choices = Major, selected="All")
  })
  

  
  output$people1 = renderTable({
    df <- inputData

    if (input$College == "All" & input$Major == "All"){
      df
    } else {
      if (input$Major == "All"){
        df <- subset(df, College == input$College)
      } 
    }
      
      if (input$College != "All" & input$Major != "All"){
        df <- subset(df, College == input$College | Major == input$Major)
      }

     

 })
  
  
  
  output$people2 = renderTable({
    df <- inputData
    
    if (input$y12 == FALSE) {
      df <- subset(df, Year != "2011-2012")
    }
    if (input$y11 == FALSE) {
      df <- subset(df, Year != "2010-2011")
    }
    if (input$y10 == FALSE) {
      df <- subset(df, Year != "2009-2010")
    }
    if (input$y09 == FALSE) {
      df <- subset(df, Year != "2008-2009")
    }
    if (input$y08 == FALSE) {
      df <- subset(df, Year != "2007-2008")
    }
    df <- subset(df, College == input$College)   
  })

  })
  




