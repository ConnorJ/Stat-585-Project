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
grad$City[grad$City == ""] <- NA
grad$Employer[grad$Employer == "Employed Unknown"] <- NA
View(data)
head(grad)


# Merge the locations into the graduation data
grad.merge <- merge(na.omit(grad), data, by = "loc")

grad.merge$College <- "College of Engineering"

levels(grad.merge$Major.1.at.Graduation)

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



levels(factor(grad.merge$Major.1.at.Graduation))
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


levels(grad.merge$Region)
head(grad)
grad[grad$Work.Type == "International Summer Internship",]


grad[grad$Job.Title == "Design Engineer",]

grad.merge$Compensation[grad.merge$Compensation == 0] <-NA
qplot(data=(subset(na.omit(grad.merge), grad.merge$Compensation <= 500000 )), x=Compensation, geom="density", bin = 5000, size = 3, ylab = "Count", fill = "white") +
  xlim(0, 150000) + scale_size(guide = 'none') + guides(fill=FALSE) +
  theme(axis.title.y = element_text(size = rel(2.5)),
        axis.title.x = element_text(size = rel(2.5)),
        axis.text.y = element_blank())


View(grad.merge)

head(grad.merge[, c(2, 7, 6, 3,4)])






