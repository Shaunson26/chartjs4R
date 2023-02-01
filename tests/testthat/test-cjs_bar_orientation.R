test_that("cjs_bar_orientation throws correct errors", {

  expect_error(cjs_bar_orientation(), regexp = 'A chartjs object must come before this function')
  expect_error(cjs_bar_orientation('no_chartjs_object'), regexp = 'p must be of class chartjs')
  expect_error(cjs_bar_orientation(chartjs(), orientation = 'wrong'), regexp = "orientation should be one of vertical, horizontal")
  expect_warning(cjs_bar_orientation(chartjs(type = 'scatter')), regexp = 'cjs_bar_orientation only works on bar plots. Skipping')

})

test_that("cjs_scale_time sets correct elementrs", {

  # horizontal
  v_bar <- cjs_bar_orientation(chartjs())
  expect_equal(v_bar$x$options$indexAxis, 'x')
  v_bar <- cjs_bar_orientation(chartjs(), orientation = 'vertical')
  expect_equal(v_bar$x$options$indexAxis, 'x')

  # horizontal
  h_bar <- cjs_bar_orientation(chartjs(), orientation = 'horizontal')
  expect_equal(h_bar$x$options$indexAxis, 'y')

})
