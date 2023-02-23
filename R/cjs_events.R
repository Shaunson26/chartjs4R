#' Edit the allowable events on a chartjs object
#'
#' Allows you to alter/remove events that the chart will respond to
#'
#' @param p a chartjs htmlwidget
#' @param events events to allow
#'
#' @return An object of class `htmlwidget`
#'
#' @export
#'
#' @examples \dontrun{
#'
#' // This chart will not respond to mousemove, etc, only clicking
#' chartjs() %>%
#'   cjs_events('click')
#'
#' }
cjs_events <- function(p, events = c('mousemove', 'mouseout', 'click', 'touchstart', 'touchmove')){
  p$x$options$events <- events
  p
}
