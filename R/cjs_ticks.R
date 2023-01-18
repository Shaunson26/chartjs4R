#' Common tick options to all axes
#'
#' These are only the common tick options supported by all axes.
#' Please see specific axis documentation for all of the available tick options
#'  for that axis. Namespace: options.scales|scaleId|.ticks
#'
#' @param backdropColor Color Yes	'rgba(255, 255, 255, 0.75)'	Color of label backdrops.
#' @param backdropPadding Padding 2	Padding of label backdrop.
#' @param callback function Returns the string representation of the tick value as it should be displayed on the chart. See callback.
#' @param display boolean	true	If true, show tick labels.
#' @param color Color Chart.defaults.color	Color of ticks.
#' @param font Font	Yes	Chart.defaults.font	See Fonts
#' @param major object {}	Major ticks configuration.
#' @param padding	number 3	Sets the offset of the tick labels from the axis
#' @param showLabelBackdrop boolean	Yes	true for radial scale, false otherwise	If true, draw a background behind the tick labels.
#' @param textStrokeColor ColorYes``	The color of the stroke around the text.
#' @param textStrokeWidth numberYes	0	Stroke width around the text.
#' @param z number 0	z-index of tick layer. Useful when ticks are drawn on chart area. Values <= 0 are drawn under datasets, > 0 on top
#'
#' @return a list
#'
#' @importFrom grDevices rgb
#'
#' @export
cjs_ticks <- function(
    backdropColor = rgb(255, 255, 255, 0.75, maxColorValue = 255),
    backdropPadding = 2,
    callback = NULL,
    display = TRUE,
    color = htmlwidgets::JS('Chart.defaults.color'),
    font = htmlwidgets::JS('Chart.defaults.font'),
    major = NULL, # to do
    padding	= 3,
    showLabelBackdrop = FALSE,
    textStrokeColor = NULL,
    textStrokeWidth = 0,
    z = 0){

  parameters <- as.list(environment())
  parameters <- get_non_null_parameters(parameters)
  parameters

}
