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
   
  sigmoid <- function(z)
  {
    1 / (1 + exp(-z))
  }
  
  f_x <- function(x)
  {
    0.2 + 0.4 * x^2 + 0.3 * x * sin(15 * x) + 0.05 * cos(50 * x)
  }
  
  stepFunction <- function(x,s,w)
  {
    o <- matrix(0,nrow = dim(x)[1], ncol = dim(x)[2])
    for(i in 1:dim(x)[1])
    {
      if (x[i,1] >= s[1,1] & x[i,1] <= s[2,1]) o[i,1] <- w[1,1]
      if (x[i,1] >= s[2,1] & x[i,1] <= s[1,1]) o[i,1] <- w[2,1]
      if (x[i,1] >= s[1,1] & x[i,1] >= s[2,1]) o[i,1] <- w[1,1] + w[2,1]
    }
    o
  }
  
  output$distPlot <- renderPlot({
    
    n <- c(0.0,0.2,0.2,0.4,0.4,0.6,0.6,0.8,0.8,1.0) # 10 neurons
    h <- c(input$weight1,input$weight2,input$weight3,input$weight4,input$weight5)
    
    s <- matrix(c(n[1],n[2]), ncol = 1) # 1o and 2o neuron
    w <- matrix(c(h[1],-h[1]),ncol=1)
    x <- matrix(seq(0,0.9,0.001),ncol=1)
    y <- stepFunction(x,s,w)
    
    j <- 1
    for (i in 2:(length(n)/2))
    {
      w <- matrix(c(h[i],-h[i]),ncol=1)
      s <- matrix(c(n[i+j],n[i+j+1]))
      y <- cbind(y, stepFunction(x,s,w))
      j <- j + 1
    }
   
    z <- f_x(x)
    
    g <- ggplot(data.frame(x,y), aes(x)) + geom_line(aes(y = z), col = "red")
    g <- g + geom_line(aes(y = y[,1]), col = "blue") 
    g <- g + geom_line(aes(y = y[,2]), col = "blue")
    g <- g + geom_line(aes(y = y[,3]), col = "blue")
    g <- g + geom_line(aes(y = y[,4]), col = "blue")
    g <- g + geom_line(aes(y = y[,5]), col = "blue")
    g <- g + geom_hline(yintercept = 0)
    g
  })
  output$Text <- renderText(
    {
      str2 <- "We are going to use a step function rather than the sigmoid function because it is easy to analyze the sum of a bunch of step functions."
      str3 <- "What is being plotted on the left is the weighted output known as neurons activations. Increasing and decreasing the step point of the hidden neurons, you will see that the graph changes this shape  over the hidden neuron activation order.
The goal is to design a neural network to appoximate the goal function plotted in red."
      paste0(str2,str3)
    }
  )
})
