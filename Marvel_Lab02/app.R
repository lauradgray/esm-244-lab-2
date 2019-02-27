# Attach packages
library(shiny)
library(tidyverse)
library(RColorBrewer)

# Load data
library(readr)
marvel <- read_csv("marvel-wikia-data.csv")
#View(marvel)

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified"

# Create the user interface 
ui <- fluidPage(
  
  theme = shinytheme("slate"),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side",
                   "Choose a side",
                   c("Good Characters",
                     "Bad Characters",
                     "Neutral Characters"))
    ), 
    
    mainPanel(
      plotOutput(outputId = "marvelplot")
    )
  )
  
)

server <- function(input, output) {
  
  output$marvelplot <- renderPlot({
    
    ggplot(filter(marvel, ALIGN == input$side), aes(x=Year)) +
      geom_bar(aes(fill = SEX), position = "fill")
    
  })
  
}





# Run the application 
shinyApp(ui = ui, server = server)

