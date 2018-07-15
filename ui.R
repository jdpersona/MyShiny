#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shinythemes)
library(shiny)
library(plotly)
library(ggplot2)
library(data.table)
library(magrittr)
library(highcharter)

data = read.csv('https://raw.githubusercontent.com/jdpersona/Dash_experiments/master/all_data.csv')
# there are 10 columns
length(colnames(data))

# convert character date to real dates
data$Begin_Date = as.Date(data$Begin_Date, "%m/%d/%y")
data$End_Date = as.Date(data$End_Date, "%m/%d/%y")

sub_data = data %>% 
  select(Begin_Date, url, form_shown, form_submitted) %>% 
  group_by(Begin_Date, url) %>% summarise (Total_form_shown = sum(form_shown), Total_form_submitted = sum(form_submitted)) %>% 
  arrange(desc(url))

sub_data$Conversion_rate =  round((sub_data$Total_form_submitted/sub_data$Total_form_shown) * 100, digits=0)

sub_data$url = trimws(sub_data$url, which='both')


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("SaaS Response",windowTitle = "SaaS Exploration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      width = 3,
      selectInput(inputId ="choose", 
                  choices = c("Watson Campaign Automation","tealeaf","digitalexperience","digitalanalytics"),    
                  selected = "Watson Campaign Automation",label = "Choose a SaaS Product"),
      br(),
      br(),
      br()
      
      
      
      
    ),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tabsetPanel(
        tabPanel("Graphs", highchartOutput("plot",height = 400, width = 1000),
                 br(),
                 highchartOutput("plot2",height = 400, width = 1000),
                 br(),
                 highchartOutput("plot3",height = 400, width = 1000),
                 br(),
                 DT :: dataTableOutput('table')
                 
        )  
                 
        ),
        
        tabPanel("Agregated Data", DT :: dataTableOutput('table2') )
        
      )
    )
    
  )
)
