test_that("cjs_add_options add options", {

  p <-
    chartjs() |>
    cjs_add_points(x = 1:10,
                   y = rnorm(10),
                   show_line = T) |>
    cjs_add_options(elements.line.tension = 0.5)

  expect_equal(p$x$options$elements$line$tension, 0.5)



})

test_that("cjs_add_options preserves options", {

  p <-
    chartjs() |>
    cjs_add_points(x = 1:10,
                   y = rnorm(10),
                   show_line = T) |>
    cjs_theme(chart.backgroundColor = 'pink') |>
    cjs_add_options(elements.line.tension = 0.5) |>
    cjs_add_options(elements.line.borderWidth = 1)

  expect_equal(p$x$options$plugins$canvasBackgroundColor$color, 'pink')
  expect_equal(p$x$options$elements$line$tension, 0.5)
  expect_equal(p$x$options$elements$line$borderWidth, 1)

})
