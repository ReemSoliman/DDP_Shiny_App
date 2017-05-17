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
  titlePanel("MaryLand Infants Mortality and Deathes 1919-2015"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("race", "Choose Race:", c("White" = "wt", "Black"  = "blk", "Both" = "both")),
      selectInput("Case", "Choose Death or Mortality:", c("Death" = "dth", "Mortality" = "mor")),
      submitButton(text = "Apply Changes", icon = NULL, width = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
    tabsetPanel( type = "tabs",
       tabPanel ("Plot",  plotOutput("plot", height = "400px", width = "600px")),
       tabPanel ("Predication",  "Prediction for the Years 2016 - 2020", br(), tableOutput("prediction") ,br(), plotOutput("prdplot") )
       )       
    )
  )
))
