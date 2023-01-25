test_that("errors thrown", {

  # no type
  #expect_error(chartjs(), regexp = 'argument "type" is missing, with no default')
  expect_error(chartjs(type = 'mouse'), regexp = "type can be only one of")
  expect_error(chartjs(type = 'bar', data = c(1)), regexp = "First argument, `data`, must be a data frame, shared data, or list")
})

test_that('plugins logic works', {

  a_plugin <- list(id = 'plugin_test', `function` = 'that')

  expect_error(chartjs(plugins = a_plugin), regexp = 'unnamed list')

  p <- chartjs(plugins = list(a_plugin))

  expect_null(names(p$x$plugins))

  can_find_test_id <- 'plugin_test' %in% sapply(p$x$plugins, function(x) x$id)

  expect_true(can_find_test_id)

})
