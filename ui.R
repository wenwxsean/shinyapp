library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting Wages"),
  
  # Sidebar with options selectors 
  sidebarLayout(
    sidebarPanel(
      helpText("This application predicts the wages based on selected variables."),
      h3(helpText("Select variables and specific values:")),
      numericInput("age", label = h4("Age"), step = 1, value = 18),
      selectInput("education", label = h4("Education"), 
                  choices = list("Unknown" = "*",
                                 "Less than high school graduate" = "^1*",
                                 "High school graduate" = "^2*",
                                 "Some college" = "^3*",
                                 "College graduate" = "^4*",
                                 "Advanced degree" = "^5*"
                  )),
      selectInput("jobclass", label=h4("Jobclass"),
                  choices = list("Unknown" = "*",
                                 "Industrial" = "^1*",
                                 "Information" = "^2*"))
    ),
    
    # Show a plot with diamonds and regression line
    mainPanel(
      plotOutput("distPlot"),
      h4("Predicted value of wage is:"),
      h3(textOutput("result"))
    )
  )
))