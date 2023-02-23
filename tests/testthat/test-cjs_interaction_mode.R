test_that("cjs_interaction_mode works", {

  p <-
    cjs_example_data('bar', grouped = TRUE) %>%
    chartjs(type = 'bar', x = letters, y = numbers, group = group)

  p <-
    p %>%
    cjs_interaction_mode('point')

  expected_value <-
    list(axis = 'xy',
         mode = 'point')

  expect_identical(p$x$options$interaction, expected_value)

  p <-
    p %>%
    cjs_interaction_mode('index')

  expected_value <-
    list(axis = 'xy',
         mode = 'index')

  expect_identical(p$x$options$interaction, expected_value)

  p <-
    p %>%
    cjs_interaction_mode('dataset')

  expected_value <-
    list(axis = 'xy',
         mode = 'dataset')

  expect_identical(p$x$options$interaction, expected_value)

  expect_error(cjs_interaction_mode(p, 'unacceptable'), regexp = "arg' should be one of")

})
