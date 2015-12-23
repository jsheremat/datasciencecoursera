library(shiny)
library(ggplot2)
library(Lahman)
library(plyr)
library(markdown)
require(markdown)

#dataset <- diamonds
data(Teams)
TF<-Teams
T2013<-Teams[Teams$yearID==2013,]

j<-T2013$teamIDlahman45
jlist<-as.list(j)
jm<-T2013$name
names(jlist)<-jm

shinyUI(
  
  navbarPage("MLB Baseball Yearly Team Stats",
           tabPanel("Explore the Data",
            sidebarLayout(
               sidebarPanel(
    
    sliderInput('Year', 'Year', min=1890, max=2013,
                value=2000,step=1,sep=""),
    
    
    selectInput('TEAM', 'TEAM', c(jlist),selected='Oakland Athletics'),
    #selectInput('TEAM', 'TEAM', c('HOU','TOR')),
    #selectInput(TF$franchID,TF$franchName)
    selectInput('Stat_type', 'Stat_type', c('Batting','Pitching','Fielding'))

  ),
  
  mainPanel(
    dataTableOutput('dTable')
  )
  

)

),
#########
tabPanel("About",
         mainPanel(
           includeHTML("Overview.html")
         )
),
########

#########
tabPanel("Batting",
         mainPanel(
           includeHTML("Batting.html")
         )
),
########

#########
tabPanel("Pitching",
         mainPanel(
           includeHTML("Pitching.html")
         )
),
########

#########
tabPanel("Fielding",
         mainPanel(
           includeHTML("Fielding.html")
         )
)
########
)

)