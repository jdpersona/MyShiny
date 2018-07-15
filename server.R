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
  
  output$plot <- renderHighchart({
    
    df_WCA = sub_data[sub_data$url == input$choose,] 
    
    highchart() %>% 
      hc_title(text = "Total Form Submitted") %>% 
      hc_add_series_times_values(df_WCA$Begin_Date,df_WCA$Total_form_submitted)
    
  })
  
  
  output$plot2 <- renderHighchart({
    
    df_WCA = sub_data[sub_data$url == input$choose, ] 
    
    highchart() %>% 
      hc_title(text = "Total Form Shown") %>% 
      hc_add_series_times_values(df_WCA$Begin_Date,df_WCA$Total_form_shown)
  })
  
  
  output$plot3 <- renderHighchart({
    
    df_WCA = sub_data[sub_data$url == input$choose, ] 
    
    highchart() %>% 
      hc_title(text = "Conversion Rate") %>% 
      hc_add_series_times_values(df_WCA$Begin_Date,df_WCA$Conversion_rate)
    
  })
  
  
  mytable <-  reactive({
    df_WCA = sub_data[sub_data$url == input$choose, ]
    
    total_growth = round(df_WCA[df_WCA$Begin_Date == max(df_WCA$Begin_Date),]['Conversion_rate']-df_WCA[df_WCA$Begin_Date == min(df_WCA$Begin_Date),]['Conversion_rate'],0)
    avg_conversion = round(sum(df_WCA$Conversion_rate)/length(df_WCA$Conversion_rate),0)
    avg_form_sub = sum(df_WCA$Total_form_submitted)/length(df_WCA$Total_form_submitted)
    avg_form_shown  = sum(df_WCA$Total_form_shown)/length(df_WCA$Total_form_shown)
    test = data.frame( "Rate" = c(avg_form_shown, avg_form_sub, paste(avg_conversion,"percent"), paste(total_growth$Conversion_rate,"percent")), row.names = c('Average Form Shown', 'Average Form Submitted', 'Average Conversion rates', 'Total Growth') )
    test
  })  
  
  
  
  output$table <- DT :: renderDataTable({           
    
    DT::datatable(mytable(), rownames = TRUE, options = list(pageLength =4))
  }, server=TRUE)
  
  
  output$table2 <- DT :: renderDataTable({           
    
    DT::datatable(sub_data[sub_data$url == input$choose, ], rownames = TRUE, options = list(pageLength =10))
    
  }, server=TRUE)
  
  
  
}
)