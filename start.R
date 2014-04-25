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
grad <- read.csv("C://Users/Connor/Documents/School Work/stat 585/Eng Job.csv")


# Convert States full names to abbrevations
grad$State <- state.abb[match(grad$State,state.name)]
grad$loc <- paste(grad$City, ",",grad$State)
grad$City[grad$City == ""] <- NA
grad$Employer[grad$Employer == "Employed Unknown"] <- NA

# Merge the locations into the graduation data
grad.merge <- merge(na.omit(grad), data, by = "loc")

grad.merge$College <- "College of Engineering"

grad.merge$Compensation[grad.merge$Compensation == ""] <- NA
grad.merge$Compensation[grad.merge$Compensation == "0.00"] <- NA
grad.merge$Compensation[grad.merge$Compensation == 0] <-NA
grad.merge$Compensation <- gsub(",", "", grad.merge$Compensation, fixed = TRUE) 
grad.merge$Compensation <- gsub("$", "", grad.merge$Compensation, fixed = TRUE) 
grad.merge$Compensation <- gsub(".00", "", grad.merge$Compensation, fixed = TRUE) 

grad.merge$Compensation <- as.numeric(grad.merge$Compensation)
grad.merge$Compensation[grad.merge$Compensation <= 100] <- grad.merge$Compensation*40*52
grad.merge$Compensation[grad.merge$Compensation == 0] <-NA


grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "Materials Science & Engineering"] <- "Materials Science and Engineering"
grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "Materials Engineering"] <- "Materials Science and Engineering"
grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "Engineering Mechanics"] <- "Other Engineering"
grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "Engineering Science (Alumni Only)"] <- "Other Engineering"
grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "College of Engineering"] <- "Other Engineering"
grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "Engineering Applications (Alumni Only)"] <- "Other Engineering"
grad.merge$Major.1.at.Graduation[grad.merge$Major.1.at.Graduation == "Agricultural Engineering"] <- "Agricultural and Biosystems Engineering"


runApp("C://Users/Connor/Documents/GitHub/Stat-585-Project/Shiny/UI and Server")


