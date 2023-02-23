test_that("cjs_add_bars works with source data", {

  data <- cjs_example_data('bar')

  p <-
    data %>%
    chartjs() %>%
    cjs_add_bars(x = letters, y = numbers, label = 'from source data')

  p_data <-
    with(p$x$data$datasets[[1]],{
      data.frame(x = sapply(data, function(d) d$x),
                 y = sapply(data, function(d) d$y))
    })

  expect_identical(p_data$x, sort(data$letters))
  expect_identical(p_data$y, data$numbers[order(data$letters)])

})

test_that("cjs_add_bars works with source data - vectors", {

  p <-
    chartjs() %>%
    cjs_add_bars(x = LETTERS[c(1,3,2,4,5)], y = 5:1, label = 'from vectors')

  p_data <-
    with(p$x$data$datasets[[1]],{
      data.frame(x = sapply(data, function(d) d$x),
                 y = sapply(data, function(d) d$y))
    })

  expect_identical(p_data$x, LETTERS[c(1,3,2,4,5)])
  expect_identical(p_data$y, 5:1)

})

test_that("cjs_add_bars works with source data - vectors", {

  p <-
    chartjs() %>%
    cjs_add_bars(x = x1, y = y1, label = 'from given data',
                 data = data.frame(x1 = LETTERS[c(5,2,4,3,1)], y1 = c(3,2,4,1,5)))

  p_data <-
    with(p$x$data$datasets[[1]],{
      data.frame(x = sapply(data, function(d) d$x),
                 y = sapply(data, function(d) d$y))
    })

  expect_identical(p_data$x, LETTERS[c(5,2,4,3,1)])
  expect_identical(p_data$y, c(3,2,4,1,5))

})
