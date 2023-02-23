test_that("single value work", {

  result <-
    chartjs() %>%
    cjs_tooltip(label = 'label_text',
                title = 'title_text', beforeTitle = 'beforeTitle_text', afterTitle = 'afterTitle_text',
                footer = 'footer_text', beforeFooter = 'beforeFooter_text', afterFooter = 'afterFooter_text')

  expected_result <-
    list(enabled = TRUE,
         callbacks = list(
           label = structure("function(e){ return (\"label_text\") }",
                             class = "JS_EVAL"),
           title =  structure("function(e){ return (\"title_text\") }",
                              class = "JS_EVAL"),
           beforeTitle = structure("function(e){ return (\"beforeTitle_text\") }",
                                   class = "JS_EVAL"),
           afterTitle = structure("function(e){ return (\"afterTitle_text\") }",
                                  class = "JS_EVAL"),
           footer = structure("function(e){ return (\"footer_text\") }",
                              class = "JS_EVAL"),
           beforeFooter = structure("function(e){ return (\"beforeFooter_text\") }",
                                    class = "JS_EVAL"),
           afterFooter = structure("function(e){ return (\"afterFooter_text\") }",
                                   class = "JS_EVAL")
         )
    )

  expect_identical( result$x$options$plugins$tooltip, expected = expected_result)
})

test_that("literals work", {

  result <-
    chartjs() %>%
    cjs_tooltip(label = 'x value: ${x}, y value: ${y}')

  expected_result <-
    list(enabled = TRUE,
         callbacks = list(
           label = structure("function(e){ return (`x value: ${e.label}, y value: ${e.formattedValue}`) }",
                             class = "JS_EVAL")
         )
    )

  expect_identical(result$x$options$plugins$tooltip, expected = expected_result)
})

test_that("map literals work", {

  result <-
    chartjs() %>%
    cjs_tooltip(label = 'x value: ${x}, y value: ${y}',
                title = 'Dataset: ${label}',
                footer = 'take with a grain of salt')

  expected_result <-
    list(enabled = TRUE,
         callbacks = list(
           label = structure("function(e){ return (`x value: ${e.label}, y value: ${e.formattedValue}`) }",
                             class = "JS_EVAL"),
           title =  structure("function(e){ let text = e.map(e => { return (`Dataset: ${e.dataset.label}`) })[0]; return text }",
                              class = "JS_EVAL"),
           footer = structure("function(e){ return (\"take with a grain of salt\") }",
                              class = "JS_EVAL")
         )
    )

  expect_identical(result$x$options$plugins$tooltip, expected = expected_result)
})



