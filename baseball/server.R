library(shiny)
library(ggplot2)
library(Lahman)

shinyServer(function(input, output) {
  
  dataTable <- reactive({
    M<-Master
    
    if (input$Stat_type=="Batting") {
    data(Master)
   
    Batting<-Batting
    #print(head(M)) 
    Year<-input$Year
    TEAM<-input$TEAM
    Batting_year<-Batting[Batting$yearID==Year,]
    
    Batting_year_team<-Batting_year[Batting_year$teamID==TEAM,]
    
    
    Batting_year_team[is.na(Batting_year_team)]<-0
    #print(Batting_year_team$AB)
    #if (Batting_year_team$AB>0){
    Batting_year_team$BatAvg<-round(Batting_year_team$H/Batting_year_team$AB,digits=4)
    Batting_year_team<- Batting_year_team[,c(1:7,25,8:24),drop=FALSE]
    
    nr<-nrow(Batting_year_team)
    
    
    #print(nr)
    
    
    
    #}
    #else {
    #  Batting_year_team$BatAvg<-0.000
    #  Batting_year_team<- Batting_year_team[,c(1:7,25,8:24),drop=FALSE]
    #}
   
    
    for(i in 1:nr){
      playerID<-Batting_year_team[i,"playerID"]
      #print(playerID)
      mp<-which(M$playerID==playerID)
      #print(mp)
      playerfirstName<-M[mp,"nameFirst"]
      playerlastName<-M[mp,"nameLast"]
      Batting_year_team[i,"playerID"]<-paste(playerfirstName,playerlastName,sep=" ")
    }
    colnames(Batting_year_team)[1] <- "Player Name"
    Batting_year_team}
    
    #if (input$Stat_type=="Pitching") {
    
    ###########
    else if (input$Stat_type=="Fielding") {
      data(Fielding)
      Year<-input$Year
      TEAM<-input$TEAM
      Fielding_year<-Fielding[Fielding$yearID==Year,]
      Fielding_year_team<-Fielding_year[Fielding_year$teamID==TEAM,]
      #print(head(Fielding_year_team))
      nr3<-nrow(Fielding_year_team)
      
      for(i in 1:nr3){
        playerID<-Fielding_year_team[i,"playerID"]
        #print(playerID)
        mp<-which(M$playerID==playerID)
        #print(mp)
        playerfirstName<-M[mp,"nameFirst"]
        playerlastName<-M[mp,"nameLast"]
        Fielding_year_team[i,"playerID"]<-paste(playerfirstName,playerlastName,sep=" ")
      }
     colnames(Fielding_year_team)[1] <- "Player Name"
      Fielding_year_team}
    ###########
    else {
      data(Pitching)
      Year<-input$Year
      TEAM<-input$TEAM
      Pitching_year<-Pitching[Pitching$yearID==Year,]
      Pitching_year_team<-Pitching_year[Pitching_year$teamID==TEAM,]
      
      nr2<-nrow(Pitching_year_team)
      
      for(i in 1:nr2){
        playerID<-Pitching_year_team[i,"playerID"]
        #print(playerID)
        mp<-which(M$playerID==playerID)
        #print(mp)
        
        
        playerfirstName<-M[mp,"nameFirst"]
        playerlastName<-M[mp,"nameLast"]
        Pitching_year_team[i,"playerID"]<-paste(playerfirstName,playerlastName,sep=" ")
        
      }
      colnames(Pitching_year_team)[1] <- "Player Name"
      Pitching_year_team}

  })
  

  # Render data table
  output$dTable <- renderDataTable({
    dataTable()
  #, options = list(bFilter = FALSE, iDisplayLength = 50)
})
})