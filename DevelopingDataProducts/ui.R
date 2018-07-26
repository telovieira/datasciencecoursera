#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Neuron Network Intuition"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("weight1",
                  "Weight 1:",
                  min = -2,
                  max = 2,
                  step = 0.1,
                  value = 0.5),
      sliderInput("weight2",
                  "Weight 2:",
                  min = -2,
                  max = 2,
                  step = 0.1,
                  value = 1),
      sliderInput("weight3",
                  "Weight 3:",
                  min = -2,
                  max = 2,
                  step = 0.1,
                  value = 0.4),
      sliderInput("weight4",
                  "Weight 4:",
                  min = -2,
                  max = 2,
                  step = 0.1,
                  value = 0.3),
      sliderInput("weight5",
                  "Weight 5:",
                  min = -2,
                  max = 2,
                  step = 0.1,
                  value = 0.3)
    ),
    
    # Show a plot
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("distPlot")),
                  tabPanel("Summary", textOutput("Text"))
      )
    )
  )
))
