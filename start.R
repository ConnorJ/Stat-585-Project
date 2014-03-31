# Prelimianry packages to install
install.packages("reshape2")
install.packages("shiny")
install.packages("leafletR")
library(shiny)
library(reshape2)
library(plyr)
library(leafletR)
library(leaflet)

if (!require(devtools))
  install.packages('devtools')
devtools::install_github('leaflet-shiny', 'jcheng5')

if (!require(maps))
  install.packages('maps')
devtools::install_github('ShinyDash', 'trestletech')

# Run shiny application
runApp("C://Users/Connor/Documents/GitHub/Stat-585-Project/Shiny/UI and Server")


# Melt lat and long into graduation data
# location has the lat and long that I need to plot my data
data <- read.csv("C://Users/Connor/Documents/GitHub/Stat-585-Project/data/locations.csv")

# Import Graduation placement data
grad <- read.csv("C://Users/Connor/Documents/GitHub/Stat-585-Project/data/585 data.csv")

# Convert States full names to abbrevations
grad$State <- state.abb[match(grad$State,state.name)]
grad$loc <- paste(grad$City, ",",grad$State)

# Merge the locations into the graduation data
grad.merge <- merge(grad, data, by = "loc")
View(grad.merge)

df <- c(2,35,25,5,2)

subset(grad.merge, Year != "2010-2012" )

is.vector(unique(5,3,254,24,12,42,3))
inputData <-grad.merge
All <- c(0,0,0,0,0,"All",0,"All",0,0,0,0,0)
levels(All)
inputData = rbind(inputData,All)
View(inputData)


data(quakes)
qks <- toGeoJSON(data=quakes, dest=tempdir())

data(quakes)
qks <- toGeoJSON(data=quakes, dest=tempdir())
head(qks)

runApp("C://Users/Connor/Documents/School Work/stat 585/leaflet-shiny-master/inst/example")




View(grad.merge)
mapdata <- ddply(grad.merge,.(City,State),transform,count = NROW(piece))


mapstuff <- mapdata[ ! duplicated( mapdata[ c("City" , "State") ] ) , ]
View(mapstuff)

