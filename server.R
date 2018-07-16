#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderHighchart({

    highchart() %>% 
      hc_title(text = "Scatter chart with size and color") %>% 
      hc_add_series_scatter(mtcars$wt, mtcars$mpg,
                            mtcars$drat, mtcars$hp)
    
  })
  
})
