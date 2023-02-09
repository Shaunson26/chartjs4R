test_that("errors thrown", {

  # no type
  #expect_error(chartjs(), regexp = 'argument "type" is missing, with no default')
  expect_error(chartjs(type = 'mouse'), regexp = "type can be only one of")
  expect_error(chartjs(type = 'bar', data = c(1)), regexp = "First argument, `data`, must be a data frame, shared data, or list")
})

test_that('plugins logic works', {

  a_plugin <- list(id = 'plugin_test', `function` = 'that')

  expect_error(chartjs(plugins = a_plugin), regexp = 'unnamed list')

  p <- chartjs(plugins = list(a_plugin))

  expect_null(names(p$x$plugins))

  can_find_test_id <- 'plugin_test' %in% sapply(p$x$plugins, function(x) x$id)

  expect_true(can_find_test_id)

})

test_that('data format correct with aes call - bar', {

  data <-
    cjs_example_data('bar', grouped = FALSE, shuffle = TRUE)

  p <-
    chartjs(data, x = letters, y = numbers, type = 'bar')

  p_data <-
    data.frame(labels = p$x$data$labels,
               x = sapply(p$x$data$datasets[[1]]$data, function(d) d$x),
               y = sapply(p$x$data$datasets[[1]]$data, function(d) d$y))

  # Sorted labels and x
  expect_identical(p_data$labels, sort(data$letters))
  expect_identical(p_data$x, sort(data$letters))
  expect_identical(p_data$y, data$numbers[order(data$letters)])

  # Grouped data
  data <-
    cjs_example_data('bar', grouped = TRUE, shuffle = TRUE)

  # 15 obs, sample some to create heterogeneity
  data <- data[sample(1:15, 12),]

  p <-
    chartjs(data, x = letters, y = numbers, group = group, type = 'bar')

  p_labels = p$x$data$labels

  p_data <-
    lapply(p$x$data$datasets, function(x){
      data.frame(
        labels = x$label,
        x = sapply(x$data, function(xx){ xx$x }),
        y = sapply(x$data, function(xx){ xx$y })
      )
    })

  p_data_df <- do.call(rbind.data.frame, p_data)
  p_data_df <- p_data_df[order(p_data_df$x, p_data_df$y, p_data_df$labels),]
  data_sort <- data[order(data$letters, data$numbers, data$group),]

  expect_identical(p_data_df$labels, data_sort$group)
  expect_identical(p_data_df$x, data_sort$letters)
  expect_identical(p_data_df$y, data_sort$numbers)

})
