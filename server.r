## Application: Demographic Comparator
##
## Description: Shiny Application which reads in demographic Counts from data sets
##              and allows viewing and comparison of those demographics over
##              multiple sets
##
## Author: JD Anderson
##
## Change History
##
##   JDA  04/26/2015  Initial Version
##
require(shiny)
require(ggplot2)

## Read in age counts, get set record totals, and calculate percentages
AgeData <- read.table("AgeData.txt",header=TRUE)
SetTotals <- aggregate(CNT~Set,data=AgeData,sum)
colnames(SetTotals) <- c("Set Name","Total Record Count")
AgeSets <- merge(AgeData,SetTotals,by.x="Set",by.y="Set Name")
AgeSets$Pct <- AgeSets$CNT / AgeSets$"Total Record Count"

## Server
shinyServer(
  function(input,output) {
    ## Generate a subset based on current application selections
    AgeSubset2 <- reactive({
      AgeSubset <- AgeSets[AgeSets$Set=="x",]
      for (i in input$Sets) {AgeSubset<-rbind(AgeSubset,AgeSets[AgeSets$Set==i,])}
      AgeSubset
    })
    ## Get and return Set Totals based on current application selections
    output$TotalSubset <- renderTable({
      TotalSubset <- SetTotals[SetTotals$Set=="x",]
      for (i in input$Sets) {TotalSubset<-rbind(TotalSubset,SetTotals[SetTotals$Set==i,])}
      TotalSubset
    })
    ## Generate the Age Plot
    output$AgePlot <- renderPlot({
      ggplot(AgeSubset2(),aes(x=Age,y=(Pct*100),group=Set,col=Set)) + geom_line(lwd=2) + ylab("Percentage of Total") + geom_vline(xintercept=input$Age)
    })
    ## Generate the Age Details header
    output$AgeHeader <- renderPrint({
      paste("Details Counts and Percentages for Age:",input$Age)
    })
    ## Generate the Age Details
    output$AgeNumber <- renderTable({
      AgeNumber <- AgeSubset2()[AgeSubset2()$Age==input$Age,c(2,3,5)]
      AgeNumber$Pct <- round(AgeNumber$Pct * 100,4)
      colnames(AgeNumber) <- c("Set Name",paste("Total Records for Age",input$Age),"Percent of Total Records")
      AgeNumber
    })
    
    }
  )


      