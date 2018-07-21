library(shiny)
library(ggplot2)
library(dplyr)
library(ISLR)
data(Wage)

# select columns to be used in the analysis
Wage2 <- Wage[,c("age", "education", "jobclass", "wage")]

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    
    # select diamonds depending of user input
    Wage2 <- filter(Wage,
                    grepl(input$education, education),
                    grepl(input$jobclass, jobclass))
    
    # build linear regression model
    fit <- lm(wage ~ age, Wage2)
    
    # predicts the price 
    pred <- predict(fit, newdata = data.frame(age = input$age,
                                              education = input$education,
                                              jobclass = input$jobclass))
    
    # Plot
    plot <- ggplot(data=Wage2, aes(x=age, y = wage))+
      geom_point(alpha = 0.3)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$age, color = "red")+
      geom_hline(yintercept = pred, color = "orange")
    plot
  })
  
  output$result <- renderText({
    
    # renders the text for the prediction below the graph
      # select diamonds depending of user input
      Wage2 <- filter(Wage,
                      grepl(input$education, education),
                      grepl(input$jobclass, jobclass))
      
      # build linear regression model
      fit <- lm(wage ~ age, Wage2)
      
      # predicts the price 
      pred <- predict(fit, newdata = data.frame(age = input$age,
                                                education = input$education,
                                                jobclass = input$jobclass))
      
      # Display results
      res <- paste("$", round(pred, digits = 2))
      res
  })
  
})