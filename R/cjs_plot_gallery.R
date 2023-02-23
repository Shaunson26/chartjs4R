#' Plot gallery for README
#'
#' Exported to png
#'
#' @import htmltools
#'
#' @return Plots in the viewer pane
cjs_plot_gallery <- function(){

  p1 <-
    cjs_example_data('bar') %>%
    chartjs(type = 'bar', x = letters, y = numbers) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'count',
                        ticks = cjs_ticks(callback = ticks_integer_callback(step = 1))) %>%
    cjs_scale_category(id = 'x',
                       grid = cjs_grid(display = FALSE)) %>%
    cjs_theme(title.text = 'A barplot', legend.position = 'none')

  p2 <-
    cjs_example_data('bar') %>%
    chartjs() %>%
    cjs_add_bars(x = letters, y = numbers, label = 'a') %>%
    cjs_add_bars(x = LETTERS[1:5], y = 5:1, label = 'b') %>%
    cjs_add_bars(x = x1, y = y1, label = 'c',
                 data = data.frame(x1 = LETTERS[1:5], y1 = rpois(5,5))) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'count',
                        ticks = cjs_ticks(callback = ticks_integer_callback(step = 1))) %>%
    cjs_scale_color(backgroundColors = c('#181E20', '#045C94','#FFBB1C')) %>%
    cjs_theme(title.text = 'A barplot with groups', legend.position = 'right') %>% {
      p <- .
      p$x$options$plugins$legend$labels$boxWidth = 20
      p
    }

  p3 <-
    cjs_example_data('scatter') %>%
    chartjs(type = 'scatter', x = x_numbers, y = y_numbers) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'Numbers on Y',
                        min = -0.2, max = 1.2) %>%
    cjs_scale_cartesian(id = 'x', title.text = 'Numbers on X',
                        min = -0.2, max = 1.2) %>%
    cjs_theme(title.text = 'A scatterplot', legend.position = 'none')

  p4 <-
    cjs_example_data('scatter') %>%
    chartjs() %>%
    cjs_add_points(x = x_numbers, y = y_numbers, label = 'a') %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
    cjs_add_points(x = x1, y = y1, label = 'c', data = data.frame(x1 = runif(12), y1 = runif(12))) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'Numbers on Y',
                        min = -0.2, max = 1.2) %>%
    cjs_scale_cartesian(id = 'x', title.text = 'Numbers on X',
                        min = -0.2, max = 1.2) %>%
    cjs_scale_color(backgroundColors = c(a = '#181E20', b = '#045C94', c = '#FFBB1C'), match_background_and_border = T) %>%
    cjs_theme(title.text = 'Scatter plot with groups')

  p5 <-
    cjs_example_data('doughnut_pie') %>%
    chartjs() %>%
    cjs_add_doughnut_pie(type = 'doughnut', x = letters, y = numbers) %>%
    cjs_theme(title.text = 'A doughnut chart', legend.position = 'right')

  p6 <-
    cjs_example_data('doughnut_pie') %>%
    chartjs() %>%
    cjs_add_doughnut_pie(type = 'pie', x = letters, y = numbers) %>%
    cjs_theme(title.text = 'A pie chart', legend.position = 'bottom') %>% {
      p <- .
      p$x$options$plugins$legend$labels$boxWidth = 20
      p
    }



  p7 <-
    cjs_example_data('scatter') %>%
    chartjs(type = 'scatter') %>%
    cjs_add_points(x = x_numbers, y = y_numbers, label = 'a', show_line = TRUE) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'Numbers on Y') %>%
    cjs_scale_cartesian(id = 'x', title.text = 'Numbers on X', offset = TRUE) %>%
    cjs_theme(title.text = 'A line plot', legend.position = 'none')

  p8 <-
    cjs_example_data('scatter') %>%
    chartjs() %>%
    cjs_add_points(x = x_numbers, y = y_numbers, label = 'a', show_line = TRUE) %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'b', show_line = TRUE) %>%
    cjs_add_points(x = x1, y = y1, label = 'c', data = data.frame(x1 = runif(12), y1 = runif(12)), show_line = TRUE) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'Numbers on Y', offset = TRUE) %>%
    cjs_scale_cartesian(id = 'x', title.text = 'Numbers on X', offset = TRUE) %>%
    cjs_scale_color(backgroundColors = c(a = '#181E20', b = '#045C94', c = '#FFBB1C'), match_background_and_border = T) %>%
    cjs_theme(title.text = 'A line plot with groups')

  p9 <-
    cjs_example_data('scatter') %>%
    chartjs() %>%
    cjs_add_points(x = x_numbers, y = y_numbers, label = 'a') %>%
    cjs_add_points(x = runif(12), y = runif(12), label = 'b') %>%
    cjs_add_points(x = x1, y = y1, label = 'c', data = data.frame(x1 = runif(12), y1 = runif(12))) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'Numbers on Y', offset = TRUE) %>%
    cjs_scale_cartesian(id = 'x', title.text = 'Numbers on X', offset = TRUE) %>%
    cjs_scale_color(backgroundColors = c(a = '#181E20', b = '#045C94', c = '#FFBB1C'), match_background_and_border = T) %>%
    cjs_scale_shape(pointStyles = c(a = cjs_shapes$circle, b= cjs_shapes$star, c = cjs_shapes$triangle)) %>%
    cjs_scale_size(pointRadii = I(6)) %>%
    cjs_theme(title.text = 'Scatter plot with groups')

  p10 <-
    cjs_example_data('scatter') %>%
    chartjs() %>%
    cjs_add_bars(x = x_time, y = y_numbers) %>%
    cjs_scale_datetime(id = 'x', time.unit = 'week', time.displayFormats = 'ccc dd MMM') %>%
    cjs_theme(title.text = 'bar plot with time axis', legend.position = 'none')

  p11 <-
    cjs_example_data('bar') %>%
    chartjs() %>%
    cjs_add_bars(x = letters, y = numbers, label = 'Data 1', data = cjs_example_data('bar')) %>%
    cjs_add_bars(x = letters, y = numbers, label = 'Data 2', data = cjs_example_data('bar')) %>%
    cjs_tooltip(label = 'x value: ${x}, y value: ${y}',
                title = 'Dataset: ${label}',
                footer = 'take with a grain of salt')
  # {
  #     p <- .
  #     p$x$options$plugins$legend$labels$boxWidth = 20
  #     p
  #   }


  div(style = c('width: 1000px; height: 700px;'),
      div(style = c('width: 100%; height: 100%;',
                    'display: grid;',
                    'grid-template-columns: 1fr 1fr 1fr 1fr; grid-template-rows: 1fr 1fr 1fr;',
                    'column-gap: 16px; row-gap: 16px;'),
          div(p1),
          div(p3),
          div(p5),
          div(p7),
          div(p2),
          div(p4),
          div(p6),
          div(p8),
          div(p9),
          div(p10),
          div(p11)
      )
  ) %>%
    htmltools::browsable()
}
