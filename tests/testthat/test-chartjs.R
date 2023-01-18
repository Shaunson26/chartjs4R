test_that("errors thrown", {

  # no type
  #expect_error(chartjs(), regexp = 'argument "type" is missing, with no default')
  expect_error(chartjs(type = 'mouse'), regexp = "type can be only one of")
  expect_error(chartjs(type = 'bar', data = c(1)), regexp = "First argument, `data`, must be a data frame, shared data, or list")
})
