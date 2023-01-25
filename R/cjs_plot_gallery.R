#' Plot gallery for README
#'
#' Exported to png
#'
#' @return Plots in the viewer pane
cjs_plot_gallery <- function(){

  p1 <-
    cjs_example_data('bar') %>%
    chartjs(type = 'bar', x = letters, y = numbers) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'count',
                        ticks = cjs_ticks(callback = ticks_integer_callback(step = 1))) %>%
    cjs_scale_category(id = 'x', labels = month.name[1:5],
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
    cjs_theme(title.text = 'A barplot with groups', legend.position = 'right')

  p3 <-
    cjs_example_data('scatter') %>%
    chartjs(type = 'scatter', x = x_numbers, y = y_numbers) %>%
    cjs_scale_cartesian(id = 'y', title.text = 'Numbers on Y',
                        min = -0.2, max = 1.2) %>%
    cjs_scale_cartesian(id = 'x', title.text = 'Numbers on X',
                        min = -0.2, max = 1.2) %>%
    cjs_theme(title.text = 'A scatterplot', legend.display = 'none')

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
    cjs_theme(title.text = 'A pie chart', legend.position = 'bottom')

  div(style = c('width: 1100px; height: 600px;',
                'display: grid;',
                'grid-template-columns: 1fr 1fr 1fr; grid-template-rows: 1fr 1fr;',
                'column-gap: 16px; row-gap: 16px;'),
      div(p1),
      div(p3),
      div(p5),
      div(p2),
      div(p4),
      div(p6),

  ) %>%
    browsable()
}
