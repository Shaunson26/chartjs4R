test_that("cjs_config_line add options", {

  p <-
    chartjs() |>
    cjs_add_points(x = 1:10,
                   y = rnorm(10),
                   show_line = T) |>
    cjs_theme(chart.backgroundColor = 'pink') |>
    cjs_add_options(elements.line = cjs_config_line(tension = 0.25, borderWidth = 1, fill = T))

  expect_equal(p$x$options$elements$line$tension, 0.25)
  expect_equal(p$x$options$elements$line$borderWidth, 1)
  expect_equal(p$x$options$elements$line$fill, TRUE)
})
