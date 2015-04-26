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
shinyUI(pageWithSidebar(
  headerPanel("Age Demographic Distribution"),
  sidebarPanel(
    h3("Set Selection:"),
    h4("Select one or more available sets to view the total Record counts and Age Distributions"),
    selectInput('Sets','',c("Set1","Set2","Set3","Set4"),selected="Set1",multiple=TRUE),
    h3("Age Selection:"),
    h4("Select a specific Age to see the detailed count and percentage information"),
    sliderInput('Age','',value=40,min=18,max=60,step=1.0)
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Overview",
               h2("Application Overview"),
               p("This is a mock-up of a real-world application currently being built for a client."),
               p("The client currently receive data feeds from multiple sources. These data sets are validated and then made available to multiple analytics teams."),
               p("While the data subjects are the same across the sets, the demographic information can differ substantially between them. Depending on the type of analysis being performed, a specific demographic pattern may be desired or required."),
               p("As the number of data sets has increased, it has become more difficult for the analytics teams to keep track of what sets are available, and what their demographic distributions are."),
               p("This application provides summary information to the analytics teams so that they can compare and contrast the various data sets in order to select a set for their analysis that most closely matches their needs."),
               p("Future versions will increase the number and type of distributions collected and reported upon."),
               h2("Instructions for Use"),
               tags$ol(tags$li("Select the tab pertaining to the demographic you would like to review (Currently only Age Provided)"),
                       tags$li("Select which data set(s) you would like to view information about. This will display the total record counts for the set and a graph of the demographic distribution. Selecting multiple sets allows you to contrast and compare their demographics"),
                       tags$li("Selecting  a specific Age on the slider will provide detailed record counts and percentages for that Age"))
               
      ),
      tabPanel("Age Demographics",
               h3("Total Records Counts for Selected Set(s)"),
               tableOutput("TotalSubset"),
               h3("Age Distributions across Set(s)"),
               plotOutput('AgePlot'),
               h3("Age Details"),
               tableOutput("AgeNumber")
      )
    )
  )
))
