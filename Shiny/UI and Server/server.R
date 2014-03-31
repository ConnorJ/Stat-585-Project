library(shiny)


inputData = grad.merge


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {
  College = c( "All", levels(unique(inputData$College)))
  
  observe({
    dfmajor <- unique(subset(inputData, College == input$College))
    Major = c( "All", levels(factor(dfmajor$Major)))
    updateSelectInput(session, "Major", choices = Major, selected="All")
  })
  
  
  

  output$people1 = renderTable({
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
    
    if (input$College == "All" & input$Major == "All"){df}
    
    if (input$College != "All" & input$Major == "All"){df <- subset(df, College == input$College)}
    
    if (input$College != "All" & input$Major != "All"){
      df <- subset(df, College == input$College & Major == input$Major)
    }
    
    df$Location <- paste(df$City, df$State)
    dfTable <- df[, c(6, 3, 2, 14, 7)]
    
    return(dfTable)
    #print(df)

 },include.rownames=FALSE)
  

  })
  




