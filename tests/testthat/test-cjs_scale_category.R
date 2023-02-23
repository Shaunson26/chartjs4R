test_that("cjs_scale_category throws correct errors", {

  expect_error(cjs_scale_category(), regexp = 'A chartjs object must come before this function')
  expect_error(cjs_scale_category('no_chartjs_object'), regexp = 'p must be of class chartjs')
  expect_error(cjs_scale_category(chartjs()), 'id must be one of x or y')
  expect_error(cjs_scale_category(chartjs(), id = 'z'), 'id must be one of x or y')

})

test_that("cjs_scale_category sets correct elements", {

  p_cat <- cjs_scale_category(chartjs(), id = 'x', title.text = 'a title')
  x_scale <- p_cat$x$options$scales$x

  expect_equal(x_scale$type, 'category')
  expect_equal(x_scale$title$display, TRUE)
  expect_equal(x_scale$title$text, 'a title')

})

test_that("cjs_scale_category warns about label inconsistency", {

  p <- chartjs(cjs_example_data('bar'), x= letters, y = numbers, type = 'bar')

  expect_warning(
    p <- cjs_scale_category(p, id = 'x', labels = month.name[1:5]),
    regexp = 'The given labels mismatch the labels in the datasets'
  )


})

