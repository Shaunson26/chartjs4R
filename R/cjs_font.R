#' Chartjs font options
#'
#' There are special global settings that can change all of the fonts on the chart.
#' These options are in Chart.defaults.font. The global font settings only apply
#' when more specific options are not included in the config.
#'
#' @param family string, "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif", Default font
#' family for all text, follows CSS font-family options.
#' @param size number, 12, Default font size (in px) for text. Does not apply to radialLinear scale point labels.
#' @param style string, 'normal', Default font style. Does not apply to tooltip title or footer.
#' Does not apply to chart title. Follows CSS font-style options (i.e. normal, italic, oblique, initial, inherit).
#' @param weight string, undefined, Default font weight (boldness). (see MDN).
#' @param lineHeight number|string,	1.2, Height of an individual line of text (see MDN).
#'
#' @return a list
#'
#' @export
cjs_font <- function(
    family = "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
    size = 12,
    style = 'normal',
    weight = NULL,
    lineHeight = 1.2){

  parameters <- as.list(environment())
  parameters <- get_non_null_parameters(parameters)
  parameters

}
