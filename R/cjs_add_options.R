#' Add/edit options of a chartjs object
#'
#' A short cut to add options to the chart object. The options object is deeply
#' nested and has many options. Rather than write a function capturing all the
#' options (and their children), this function allows you to specify them using
#' a . (dot) notation e.g. elements.line.tension = 0.25 expands to
#' \{elements: \{line: \{tension: 0.25\}\}\}. Thus you must determine the options you
#' desire from the [chartjs documention](https://www.chartjs.org/docs/latest/configuration/).
#' Any previously set options should be preserved ...
#'
#' @param p chartjs object
#' @param ... any chartjs option, using . notation
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_add_options <- function(p, ...){

  #chartjs_output$x$options$elements$line$tension = 0.25
  #chartjs_output$x$options$elements$line$borderJoinStyle = 'round'

  # Capture arguments
  parameters <- list(...)
  parameters <- get_non_null_parameters(parameters)
  parameters <- relist_parameter_vector(parameters)

  # Update data
  p$x$options <-
    modify_list(p$x$options, parameters)

  # Return plot
  p
}
