test_that("chartjsProxy defaults work", {

  suppressWarnings(
    shinytest2::load_app_env()
  )

  ui <-
    fluidPage(
      chartjsOutput("distPlot", height = '300px'),
    )

  # Define server logic required to draw a histogram
  server <- function(input, output, session) {

    data <- reactive({
      data.frame(x = 1:5, y = 5:1)
    })

    output$distPlot <- renderChartjs({
      chartjs(type = 'bar')
    })

    observe({
      chartjsProxy('distPlot') %>%
        cjs_update_bars(data = data(), x = 'x', y = 'y')
    }) %>%
      bindEvent(data())

    # exportTestValues(
    #   chartjsProxy = { chartjsProxy_value() }
    # )
  }

  # Run the application
  app <- shinytest2::AppDriver$new(shinyApp(ui = ui, server = server))

  observed_labels <- unlist(app$get_js("get_chartjs('distPlot').data.labels"))
  observed_data <- unlist(app$get_js("get_chartjs('distPlot').data.datasets[0].data"))

  expect_equal(observed_labels, 1:5)
  expect_equal(observed_data, 5:1)

  app$stop()
})
