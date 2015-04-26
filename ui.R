library(shiny)
library(ggplot2)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel("Singapore Housing Price Quick Prediction 2015"),
        
        # Sidebar with controls to select the postal district and 
        # specify the size of the apartment/condo
        sidebarPanel(
                selectInput("pd", "Choose a postal district:", 
                            choices = c("01", "02", "03", "04", "05",
                                        "06", "07", "08", "09", "10",
                                        "11", "12", "13", "14", "15",
                                        "16", "17", "18", "19", "20",
                                        "21", "22", "23", "24", "25",
                                        "26", "27", "28")),
                
                numericInput("area", "Area (sqft):", 1000),
                submitButton("Submit")
        ),
        
        # Show chart and prediction results
        mainPanel(
                h3("Mean psf chart by Postal District"),
                plotOutput("op6"),
                h3("Results of Prediction"),
                h4("You have selected"),
                verbatimTextOutput("op1"),
                h4("The average unit price (in S$ psf) for"),
                verbatimTextOutput("op5"),
                h4("is"),
                verbatimTextOutput("op2"),
                h4("For a size (in sqft) of"),
                verbatimTextOutput("op3"), 
                h4("The estimated price is (in S$)"),
                verbatimTextOutput("op4")
        )
))