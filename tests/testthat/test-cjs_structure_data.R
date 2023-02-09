test_that("structures data correctly works", {

  data <- cjs_example_data('bar')
  names(data)[1:2] <- c('x', 'y')

  expected_value <-
    list(datasets = list(
      list(
        label = 'g1',
        data = data_to_xy_list(data)
      )
    ),
    labels = data$x
    )

  expect_identical(cjs_structure_data(data, 'bar'), expected_value)

  expected_value <-
    list(datasets = list(
      list(
        label = 'g1',
        data = data$y
      )
    ),
    labels = data$x
    )

  expect_identical(cjs_structure_data(data, 'doughnut'), expected_value)
  expect_identical(cjs_structure_data(data, 'pie'), expected_value)

  expected_value <-
    list(datasets = list(
           list(
             label = 'g1',
             data = data_to_xy_list(data)
           )
         )
    )

  expect_identical(cjs_structure_data(data, 'scatter'), expected_value)

})
