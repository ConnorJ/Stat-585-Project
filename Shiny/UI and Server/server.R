library(shiny)


inputData = grad.merge
mapdata <- ddply(grad.merge,.(City,State),transform,count = NROW(piece))
mapstuff <- mapdata[ ! duplicated( mapdata[ c("City" , "State") ] ) , ]

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {

  map <- createLeafletMap(session, 'map')
  
  
  citiesInBounds <- reactive({
    if (is.null(input$map_bounds))
      return(inputData[FALSE,])
    bounds <- input$map_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)
    
    subset(inputData,
           Lat >= latRng[1] & Lat <= latRng[2] &
             Long >= lngRng[1] & Long <= lngRng[2])
  })
  
  
  radiusFactorcalc<- reactive({ radiusFactor <- 100000 * as.numeric(input$radius)  })
  
  observe({
    radiusFactor <- radiusFactorcalc()
    map$clearShapes()
    #cities <- topCitiesInBounds()
    
    if (nrow(mapstuff) == 0)
      return()
    
    map$addCircle(
      mapstuff$Lat,
      mapstuff$Long,
      sqrt(mapstuff[["count"]]) * radiusFactor / max(5, input$map_zoom)^2,
      row.names(mapstuff),
      list(
        weight=1.2,
        fill=TRUE,
        color='#999933'
      )
    )
  })
  
  
  College = c( "All", levels(unique(inputData$College)))
  
  observe({
    dfmajor <- unique(subset(inputData, College == input$College))
    Major = c( "All", levels(factor(dfmajor$Major)))
    updateSelectInput(session, "Major", choices = Major, selected="All")
  })


  output$people1 = renderDataTable({
    df <- citiesInBounds()
    
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
    

 })
  

  })
  




