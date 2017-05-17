#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(forecast)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
    mi <- read.csv("Maryland_Infants1.csv")
 
    output$plot <- renderPlot({
      if(input$Case == "mor")
      {
        if(input$race == "wt"){
          # plot(data$Year, data$InfantMortalityRateWhite, col="orange") 
          yvar <- mi$InfantMortalityRateWhite
          yLabel <- "White Infant Mortality Rate "
         # z<- ts(mi$InfantMortalityRateWhite,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "blk"){
          yvar <- mi$InfantMortalityRateBlack
          yLabel <- "Black Infant Mortality Rate "
          #z<- ts(mi$InfantMortalityRateBlack,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "both"){
          yvar<- mi$InfantMortalityRateTotal
          yLabel <- "Black and White Infant Mortality Rate "
          #z<- ts(mi$InfantMortalityRateTotal,start = c(1919) , end=c(2015), frequency = 1)
        }
        
        
        
      }
      else if(input$Case == "dth"){
        if(input$race == "wt"){
          yvar<- mi$NumberOfInfantDeathsWhite
          yLabel <- "White Infant Deaths Number "
          #z<- ts(mi$NumberOfInfantDeathsWhite,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "blk"){
          yvar<-  mi$NumberOfInfantDeathsBlack
          yLabel <- "Black Infant Deaths Number "
          #z<- ts(mi$NumberOfInfantDeathsBlack,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "both"){
          yvar<- mi$NumberOfInfantDeathsTotal
          yLabel <- "Black and White Infant Deaths Number "
          #z<- ts(mi$NumberOfInfantDeathsTotal,start = c(1919) , end=c(2015), frequency = 1)
        }
        #lines()
        
      }
      
      p<- ggplot(mi,  aes(Year, yvar))+ 
        geom_point(aes(color = yvar)) +
        geom_smooth(method ="lm") +
        ylab(yLabel)
        print(p)
    })
    
    
    predicted <- reactive({
      
      if(input$Case == "mor")
      {
        if(input$race == "wt"){
          
           z<- ts(mi$InfantMortalityRateWhite,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "blk"){
          
          z<- ts(mi$InfantMortalityRateBlack,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "both"){
          
          z<- ts(mi$InfantMortalityRateTotal,start = c(1919) , end=c(2015), frequency = 1)
        }
        
        
        
      }
      else if(input$Case == "dth"){
        if(input$race == "wt"){
          
          z<- ts(mi$NumberOfInfantDeathsWhite,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "blk"){
          
          z<- ts(mi$NumberOfInfantDeathsBlack,start = c(1919) , end=c(2015), frequency = 1)
        }
        else if(input$race == "both"){
          
          z<- ts(mi$NumberOfInfantDeathsTotal,start = c(1919) , end=c(2015), frequency = 1)
        }
      }
        
     fit <- HoltWinters(z, beta=FALSE, gamma=FALSE)
     f<- forecast(fit, 5)
     
     #y<- data.frame(date=as.POSIXct(time(for_means)), Prediction Mean=as.matrix(for_means) )
     })
    
     output$prediction<- renderTable({ 
       f <- predicted()
       for_means<-   f$mean
       y<- data.frame(Year=time(for_means), Prediction =as.matrix(for_means) )
    
  })
     output$prdplot<- renderPlot({ plot(predicted() ) })
  
})
