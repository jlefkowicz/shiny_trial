library(shiny)
library(tidyverse)

faithful <- as_tibble(datasets::faithful[, 2])

# UI
ui <- fluidPage(
  
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "bins",
        label = "Number of bins:",
        min = 1,
        max = 60,
        value = 30
      )
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Server
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    ggplot(faithful, aes(x = value)) +
      geom_histogram(
        bins = input$bins,
        fill = "steelblue",
        color = "white"
      ) +
      labs(
        x = "Waiting time to next eruption (in mins)",
        y = "Count",
        title = "Histogram of waiting times"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(
          hjust = 0.5,
          size = rel(1.5),
          face = "bold",
          margin = margin(0, 0, 30, 0)
        ),
        axis.title.x = element_text(
          size = rel(1.5),
          margin = margin(30, 0, 0, 0)
        ),
        axis.title.y = element_text(
          size = rel(1.5),
          margin = margin(0, 30, 0, 0)
        ),
        axis.text.x = element_text(size = rel(1.2)),
        axis.text.y = element_text(size = rel(1.2))
      )
    
  })
}

# Run app
shinyApp(ui = ui, server = server)