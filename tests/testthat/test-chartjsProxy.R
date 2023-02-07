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

    output$distPlot <- renderChartjs({
      data.frame(x = 1:5, y = 5:1) %>%
        chartjs(type = 'bar') %>%
        cjs_add_bars(x = 'x', y = 'y')
    })

    chartjsProxy_value <- reactive({
      chartjsProxy('distPlot')
    })

    exportTestValues(
      chartjsProxy = { chartjsProxy_value() }
    )
  }

  # Run the application
  app <- shinytest2::AppDriver$new(shinyApp(ui = ui, server = server))
  chartjsProxy_value <- app$get_values()$export$chartjsProxy

  expect_equal(chartjsProxy_value$id, 'distPlot')
  expect_true(inherits(chartjsProxy_value, 'chartjs_proxy'))
  expect_true(chartjsProxy_value$deferUntilFlush)

  app$stop()
})
