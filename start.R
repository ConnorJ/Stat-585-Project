# Prelimianry packages to install
install.packages("reshape2")
install.packages("shiny")
install.packages("leafletR")
library(shiny)
library(reshape2)
library(plyr)
library(leafletR)

library(leaflet)if (!require(devtools))
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
grad <- read.csv("C://Users/Connor/Documents/School Work/stat 585/Eng Job.csv")


# Convert States full names to abbrevations
grad$State <- state.abb[match(grad$State,state.name)]
grad$loc <- paste(grad$City, ",",grad$State)
View(data)
View(grad.merge)


# Merge the locations into the graduation data
grad.merge <- merge(grad, data, by = "loc")

grad.merge$College <- "College of Engineering"

grad.merge$Compensation[grad.merge$Compensation == ""] <- NA
grad.merge$Compensation[grad.merge$Compensation == "0.00"] <- NA
grad.merge$Compensation <- gsub(",", "", grad.merge$Compensation, fixed = TRUE) 
grad.merge$Compensation <- gsub("$", "", grad.merge$Compensation, fixed = TRUE) 
grad.merge$Compensation <- gsub(".00", "", grad.merge$Compensation, fixed = TRUE) 

# Run shiny application
runApp("C://Users/Connor/Documents/GitHub/Stat-585-Project/Shiny/UI and Server")

library(ggplot2)
qplot(data=grad.merge, x=Salary, geom="histogram", bin = 3000)

as.numeric(grad.merge$Compensation)

ggplot(subset(na.omit(grad.merge), grad.merge$Compensation != 0), aes(x=Compensation)) + geom_density()

grad.merge$Compensation[grad.merge$Compensation == ""] <- NA
grad.merge$Compensation <- gsub(",", "", grad.merge$Compensation, fixed = TRUE) 
grad.merge$Compensation <- gsub("$", "", grad.merge$Compensation, fixed = TRUE) 
grad.merge$Compensation <- gsub(".00", "", grad.merge$Compensation, fixed = TRUE) 

gsub(".00" | "$", "", "$1,234,567.00", fixed = TRUE) 

inputData <- grad.merge

levels(unique(inputData$College))

College = c( "All", levels(unique(inputData$College)))
College
WorkType = c( "All", levels(unique(inputData$Work.Type)))
WorkType

subset(grad.merge, College == input$College & (Major == input$Major | Major == input$Major )
       
       dfmajor <- unique(subset(inputData, College == "College of Engineering"))
       Major = c( "All", levels(dfmajor$Major.1.at.Graduation))
       
       levels(dfmajor$Major.1.at.Graduation)
Major
