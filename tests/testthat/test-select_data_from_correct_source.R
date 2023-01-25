test_that("Selections work", {

  # Minimal inputs
  p <- list(x = list(source_data = data.frame(x = 1:5, y = 1:5)))
  data <- NULL
  dots <- rlang::quos(x = x, y = y)
  result <- select_data_from_correct_source(p, data = data, dots_quo = dots)
  expect_identical(result, p$x$source_data)

  data <- data.frame(x = 5:1, y = 1:5)
  dots <-rlang::quos(x = x, y = y)
  result <- select_data_from_correct_source(p, data = data, dots_quo = dots)
  expect_identical(result, data)

  data <- NULL
  dots <- rlang::quos(x = LETTERS[1:5], y = letters[1:5])
  result <- select_data_from_correct_source(p, data = data, dots_quo = dots)
  expect_identical(result, as.data.frame(lapply(dots, rlang::eval_tidy)))

  p <- NULL
  data <- NULL
  dots <- rlang::quos(x = x, y = y)
  expect_error(select_data_from_correct_source(p, data = data, dots_quo = dots), regexp = 'No source data exists nor was data specified')


  # Extra inputs ... only 'data_selector_vars' within function selected
  p <- list(x = list(source_data = data.frame(x = 1:5, y = 1:5)))
  data <- NULL
  dots <- rlang::quos(x = x, y = y, colors = palette()[1:5])
  result <- select_data_from_correct_source(p, data = data, dots_quo = dots)
  expect_identical(result, p$x$source_data)

})
