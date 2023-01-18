#' Remove Chartjs legend
#'
#' Remove legend from Chartjs plot
#'
#' @param p chartjs object
#'
#' @export
cjs_remove_legend <- function(p){
  p$x$options$plugins$legend$display <- FALSE
  p
}
