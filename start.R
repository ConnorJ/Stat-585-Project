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

# Run shiny application
runApp("C://Users/Connor/Documents/GitHub/Stat-585-Project/Shiny/UI and Server")

