test_that("structures data correctly works", {
  data <- cjs_example_data('bar')
  names(data)[1:2] <- c('x', 'y')

  expected_value <-
    list(labels = data$x,
         datasets = list(
           list(
             label = 'dataset 1',
             data = data$y
           )
         )
    )

  expect_identical(cjs_structure_data(data, 'bar'), expected_value)
  expect_identical(cjs_structure_data(data, 'doughnut'), expected_value)
  expect_identical(cjs_structure_data(data, 'pie'), expected_value)

  expected_value <-
    list(labels = NULL,
         datasets = list(
           list(
             label = 'dataset 1',
             data = apply(data[, c('x', 'y')], 1, as.list)
           )
         )
    )

  expect_identical(cjs_structure_data(data, 'scatter'), expected_value)

})
