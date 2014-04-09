Continuing the Adventure after Iowa State
========================================================
Project Report Draft
========================================================

By: Connor Jennings

The goal of this project is to make employment statistics that are collected though the Iowa State Career services for the different colleges more accessible to the everyday student.

The first step was to research R web technologies that could better display the data. I decided a shiny app with an interactive map that could filter out the majors and colleges and returned a searchable data table. 

I came across a package called "Leaflet R" which was in development by Joe Cheng and I downloaded it into R using the developer tool. The map used Javascript which gave the user the ability to zoom in and move the view on the map around much like a Google map application. Another feature is the map is aware of the boundaries of the viewed portion of the map in the shiny app. Using this feature, you can filter out the data frame to only display careers located on the viewed portion of the map. Which allows student so filter searches to only areas they desire to work.

Using a data set containing cities, states, latitudes and longitudes, I merge that data with the cities and states in the employment data and then plotted the points on the map. One of the problem I ran into was that not all the cities in my employment data were in the cities list, so when they were merged together, about 10% of the data points were lost. I am currently trying to find a larger more complete data set to merge with the employment data, but this is proving to be harder than originally anticipated.

Another problem that I have been running into most in the College of Design is students are working freelance and do not have a city listed and there for can not be placed on the map. These students should be listed to show current students the true employment options they have in each degree program, but at this point, I am still unsure how to represent these students. 

Also I am trying to better filter all the data and standardize it. Just the job position "free-lance" can be listed many different ways; free-lance, freelance, freelancer, freelance consultant and they can be placed in either the company or job title variable or both. I want to make the title standardized to make the searchable data frame more useable.

Additional user features that have been added are a table of the highest employers in the viewed area and a histogram of salary data. 

The current information and how it is displayed is in the shiny app is very user friendly and has been tested by my roommates. The current goal for the rest of the project is to better clean the data and find a larger data set of latitudes and longitudes and get the application working on the shiny server.


