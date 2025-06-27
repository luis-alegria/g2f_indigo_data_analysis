#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Michigan Sample Read Genus Composition"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(width = 3,
          selectInput("sample", "Sample:", 
                      choices = read.csv("genus_transpose.csv")$X )
        ),

        # Show plot
        mainPanel(
            plotOutput("plot", height = "900px")
        )
    )
)
