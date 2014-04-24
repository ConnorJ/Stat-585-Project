library(shiny)
library(ggplot2)

inputData = grad.merge
mapdata <- ddply(grad.merge,.(City,State),transform,count = NROW(piece))
mapstuff <- mapdata[ ! duplicated( mapdata[ c("City" , "State") ] ) , ]

i = 1

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {
  
  
 if(i ==1){
   map <- createLeafletMap(session, 'map')
   i <- i + 1
 }  
  
  
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
  
  
  filter <- reactive({  
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
      df <- subset(df, College == input$College & Major.1.at.Graduation == input$Major | Major.2.at.Graduation == input$Major )
    }
    df$Location <- paste(df$City, df$State)
    return(df)
  })
  
  mapfilter <- reactive({  
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
    return(df)
  })
  
  radiusFactorcalc<- reactive({ radiusFactor <- 5000 * (as.numeric(input$radius)^2 +1) })
  
  observe({
    radiusFactor <- radiusFactorcalc()
    map$clearShapes()
    
    mapdffilter <- filter()
    #mapdffilter <- mapfilter()
    mapdata <- ddply(mapdffilter,.(City,State),transform,count = NROW(piece))
    mapstuff <- mapdata[ ! duplicated( mapdata[ c("City" , "State") ] ) , ]
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
    dfmajor <- unique(subset(inputData, College == "College of Engineering"))
    Major = c( "All", levels(dfmajor$Major.1.at.Graduation))
    updateSelectInput(session, "Major", choices = Major, selected="All")
  })
  


    
    
  output$people1 = renderDataTable({
    df <- filter()
    
    dfTable <- df[, c(6, 3, 2, 15, 7)]
    
    return(dfTable)
  })
  
  
  output$companies1 = renderTable({
    df <- filter()
    if (nrow(df)>0){
      df <- count(df,"Employer")
      df <- df[order(df$freq, decreasing = TRUE),]
      colnames(df) <- c("Employer","Employees")
      if (nrow(df)<5) {
        df<- df[1:nrow(df),]
        return(df)
      } else {
        df<- df[1:5,]
        return(df)
      }
    } 
  },include.rownames=FALSE)
  
  output$plot1 = renderPlot({
    df  <- filter()
    if (nrow(df)>=5){
      print(qplot(data=(subset(na.omit(grad.merge), grad.merge$Compensation != 0)), x=Compensation, geom="histogram", bin = 5000))
    } else {print("Not Enough Data")}
    
  })
  
  
})



