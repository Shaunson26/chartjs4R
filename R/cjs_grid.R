#' Grid Line Configuration
#'
#' Namespace: options.scales|scaleId|.grid, it defines options for the grid lines
#' that run perpendicular to the axis
#'
#' @param circular boolean FALSE If true, gridlines are circular (on radar and polar area charts only).
#' @param color Color Yes Yes
#' @param display boolean TRUE If false, do not display grid lines for this axis.
#' @param drawOnChartArea boolean TRUE If true, draw lines on the chart area inside the axis lines. This is useful when there are multiple axes and you need to control which grid lines are drawn.
#' @param drawTicks boolean TRUE If true, draw lines beside the ticks in the axis area beside the chart.
#' @param lineWidth number Yes Yes
#' @param offset boolean FALSE If true, grid lines will be shifted to be between labels. This is set to true for a bar chart by default.
#' @param tickBorderDash number[] Length and spacing of the tick mark line. If not set, defaults to the grid line borderDash value.
#' @param tickBorderDashOffset number Yes Yes
#' @param tickColor Color Yes Yes
#' @param tickLength number 8 Length in pixels that the grid lines will draw into the axis area.
#' @param tickWidth number Yes Yes
#' @param z number -1 z-index of the gridline layer. Values <= 0 are drawn under datasets, > 0 on top.
#'
#' @return a list
#'
#' @export
cjs_grid <- function(
    circular = FALSE,
    color = htmlwidgets::JS('Chart.defaults.borderColor'),
    display = TRUE,
    drawOnChartArea = TRUE,
    drawTicks = TRUE,
    lineWidth = 1,
    offset = FALSE,
    tickBorderDash = NULL,
    tickBorderDashOffset = NULL,
    tickColor = NULL,
    tickLength = 8,
    tickWidth = NULL,
    z = -1){

  parameters <- as.list(environment())
  parameters <- get_non_null_parameters(parameters)
  parameters

}
