#' Border Configuration
#'
#' Namespace: options.scales|scaleId|.border, it defines options for the border that run perpendicular to the axis.
#'
#' @param display boolean If true, draw a border at the edge between the axis and the chart area.
#' @param color The color of the border line. Defaults to Chart.defaults.borderColor
#' @param width number   1 The width of the border line.
#' @param dash number[] Yes  [] Length and spacing of dashes on grid lines. See MDN
#' @param dashOffset number Yes  0 Offset for line dashes. See MDN
#' @param z number   0 z-index of the border layer. Values <= 0 are drawn under datasets, > 0 on top.
#'
#' @return a list
#'
#' @export
cjs_border <-
  function(display = TRUE,
           color = htmlwidgets::JS('Chart.defaults.borderColor'),
           width = 1,
           dash = NULL,
           dashOffset = 0,
           z = 0){

    parameters <- as.list(environment())
    parameters <- get_non_null_parameters(parameters)
    parameters
  }
