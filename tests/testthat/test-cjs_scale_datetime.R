test_that("cjs_scale_datetime throws correct errors", {

  expect_error(cjs_scale_datetime(), regexp = 'A chartjs object must come before this function')
  expect_error(cjs_scale_datetime('no_chartjs_object'), regexp = 'p must be of class chartjs')
  expect_error(cjs_scale_datetime(chartjs()), 'id must be one of x or y')
  expect_error(cjs_scale_datetime(chartjs(), id = 'z'), 'id must be one of x or y')

})

test_that("cjs_scale_datetime sets correct elements", {

  p_time <- cjs_scale_datetime(chartjs(), id = 'x', time.unit = 'day')
  x_scale <- p_time$x$options$scales$x

  expect_equal(x_scale$type, 'time')
  # no time.displayFormats set
  expect_equal(x_scale$time$unit, 'day')

  # single time.displayFormats sets single displayFormat with same name
  p_time <- cjs_scale_datetime(chartjs(), id = 'x', time.unit = 'day', time.displayFormats = 'dd')
  x_scale <- p_time$x$options$scales$x

  expect_equal(x_scale$time$unit, 'day')

  x_scale_displayFormats <- x_scale$time$displayFormats
  expect_equal(names(x_scale_displayFormats), 'day')
  expect_equal(x_scale_displayFormats$day, 'dd')

})
