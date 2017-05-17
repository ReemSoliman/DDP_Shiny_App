#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Maryland State Infants Mortality and Deaths "),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("race", "Choose Race:", c("White" = "wt", "Black"  = "blk", "Both" = "both")),
      selectInput("Case", "Choose Deaths or Mortality:", c("Deaths" = "dth", "Mortality" = "mor")),
      submitButton(text = "Submit", icon = NULL, width = NULL),
      
      helpText("Please choose the Race and Mortality/ Deaths, then click Submit button, the plot of the years 1919-2015  will be displayed 
               in the Historical Data tab and the Prediction of the years 2016-2020 will be displayed in the Predication tab.")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
    tabsetPanel( type = "tabs",
       tabPanel ("Historical Data", "The data for the years 1919-2015", br(), plotOutput("plot", height = "400px", width = "600px")),
       tabPanel ("Predication",  "Prediction for the Years 2016 - 2020", br(), tableOutput("prediction") ,br(), plotOutput("prdplot") )
       )       
    )
  )
))
