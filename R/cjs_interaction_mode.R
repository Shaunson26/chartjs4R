#' Interaction Modes
#'
#' Used for tooltip position mode setting. Should hover show a single data point,
#' the various groups (if any) at a particular x value, or the dataset of the
#' datapoint?
#'
#' @param p a chartjs htmlwidget
#' @param mode type of interaction to allow
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_interaction_mode <- function(p, mode = c('point', 'index', 'dataset')){

  mode = match.arg(mode, choices = c('point', 'index', 'dataset'))
  p$x$options$interaction$axis = 'xy'
  p$x$options$interaction$mode = mode
  p
}
