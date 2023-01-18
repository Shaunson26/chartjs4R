test_that("unnamed backgroundColors works", {

  unnamed_colours <- palette()[1:3]

  p <-
    chartjs() %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'a') %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'c') %>%
    cjs_scale_color(backgroundColors = unnamed_colours)

  backgroundColor_added <- sapply(p$x$data$datasets, function(x) x$backgroundColor)

  expect_identical(backgroundColor_added, unnamed_colours)

})

test_that("more unnamed backgroundColors works and gives a warning", {

  unnamed_colours <- palette()[1:4]

  expect_warning({
    p <-
      chartjs() %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'a') %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'c') %>%
      cjs_scale_color(backgroundColors = unnamed_colours)
  })

  backgroundColor_added <- sapply(p$x$data$datasets, function(x) x$backgroundColor)

  expect_identical(backgroundColor_added, unnamed_colours[1:3])

})

test_that("one unnamed backgroundColors and multiple datasets throws a warning", {

  unnamed_colours <- palette()[1]

  expect_warning({
    p <-
      chartjs() %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'a') %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'c') %>%
      cjs_scale_color(backgroundColors = unnamed_colours)
  })

  backgroundColor_added <- sapply(p$x$data$datasets, function(x) x$backgroundColor)

  expect_identical(backgroundColor_added, rep(unnamed_colours, length(backgroundColor_added)))

})

test_that("named backgroundColors works", {

  # shuffle names to ensure function works
  named_colours <- palette()[1:3]
  names(named_colours) <- letters[c(3,1,2)]

  p <-
    chartjs() %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'a') %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'c') %>%
    cjs_scale_color(backgroundColors = named_colours)

  backgroundColor_added <-
    sapply(p$x$data$datasets, function(x) {
      out <- x$backgroundColor
      names(out) <- x$label
      out
    })


  expect_identical(backgroundColor_added, named_colours[names(backgroundColor_added)])

})

test_that("less unnamed backgroundColors works and gives a warning", {

  # shuffle names to ensure function works
  named_colours <- palette()[1:2]
  names(named_colours) <- letters[c(3,1)]

  expect_warning({
    p <-
      chartjs() %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'a') %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
      cjs_add_points(x = runif(12), y = runif(12), label = 'c') %>%
      cjs_scale_color(backgroundColors = named_colours)
  })

  backgroundColor_added <-
    sapply(p$x$data$datasets, function(x) {
      # default colour is currently NULL
      out <- x$backgroundColor
      out <- ifelse(is.null(out), NA, out)
      names(out) <- x$label
      out
    })


  expect_identical(backgroundColor_added[names(named_colours)], named_colours)

})


