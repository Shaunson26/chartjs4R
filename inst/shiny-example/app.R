library(shiny)
library(chartjs4r)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Chartjs Shiny example"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda",
                  "lambda:",
                  min = 1,
                  max = 50,
                  value = 30),
      h4('Clicked data values'),
      verbatimTextOutput('distPlotClickedData')
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3('Destroy/recreate'),
      chartjsOutput("distPlot", height = '300px'),
      h3('Proxy update'),
      chartjsOutput("distPlot2", height = '300px'),
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  data <- reactive({
    values <- rpois(100, lambda = input$lambda)
    values_counts <- as.data.frame(table(values))
    values_counts_full <- data.frame(values = 0:75)
    values_counts_full <- merge.data.frame(values_counts_full, values_counts, all = TRUE)
    values_counts_full$Freq <- replace(values_counts_full$Freq, is.na(values_counts_full$Freq), 0)
    values_counts_full
  })

  # This example destroys and recreates the chartjs instance
  output$distPlot <- renderChartjs({
    data() %>%
      chartjs(return_data_ids = TRUE) %>%
      cjs_add_bars(x = values, y = Freq)
  })

  # This example updates the data in a chartjs instance
  output$distPlot2 <- renderChartjs({
    chartjs(type = 'bar') %>%
      cjs_bar_orientation(orientation = 'horizontal')
  })

  observe({
    chartjsProxy('distPlot2') %>%
      cjs_update_bars(data = data(), x = values, y = Freq)
  }) %>%
    bindEvent(data())

  observe({
    res <- input$distPlot_clicked
    print(
      data()[res$index + 1,]
    )
    proxy <- chartjsProxy('distPlot2')
    # list (index, dataset)
    message <- list(id = proxy$id, ActiveDataPoint = res)
    proxy$session$onFlushed(once=TRUE, function(){
      proxy$session$sendCustomMessage("set-active-elements", message)
    })
  }) %>%
    bindEvent(input$distPlot_clicked)

  output$distPlotClickedData <- renderPrint({
    input$distPlot_clicked
  }) %>%
    bindEvent(input$distPlot_clicked)
}

# Run the application
shinyApp(ui = ui, server = server)
