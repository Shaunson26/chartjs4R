#' Line Configuration
#'
#' Line elements are used to represent the line in a line chart.

#' @param tension number 0	Bézier curve tension (0 for no Bézier curves).
#' @param backgroundColor Color Chart.defaults.backgroundColor	Line fill color.
#' @param borderWidth	number	3	Line stroke width.
#' @param borderColor	Color Chart.defaults.borderColor	Line stroke color.
#' @param borderCapStyle	string	'butt'	Line cap style. See MDN
#' @param borderDash	number[]	[]	Line dash. See MDN
#' @param borderDashOffset	number	0.0	Line dash offset. See MDN
#' @param borderJoinStyle	'round'|'bevel'|'miter'	'miter'	Line join style. See MDN
#' @param capBezierPoints	boolean	true	true to keep Bézier control inside the chart, false for no restriction.
#' @param cubicInterpolationMode	string	'default'	Interpolation mode to apply. See more...
#' @param fill	boolean|string	false	How to fill the area under the line. See area charts.
#' @param stepped	boolean	false	true to show the line as a stepped line (tension will be ignored).
#'
#' @return a list
#'
#' @export
cjs_config_line <- function(
  tension = 0,
  backgroundColor = NULL,
  borderWidth = 3,
  borderColor = NULL,
  borderCapStyle = 'butt',
  borderDash = NULL,
  borderDashOffset = NULL,
  borderJoinStyle = 'miter',
  capBezierPoints = TRUE,
  cubicInterpolationMode = 'default',
  fill = FALSE,
  stepped = FALSE) {

  parameters <- as.list(environment())
  parameters <- get_non_null_parameters(parameters)
  parameters

}
