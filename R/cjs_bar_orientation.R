#' Alter the bar orientation
#'
#' @param p a chartjs object
#' @param orientation one of 'vertical' or 'horizontal'
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_bar_orientation <- function(p, orientation = c('vertical', 'horizontal')){

  if (!is.null(p$x$type) && p$x$type != 'bar'){
    warning('cjs_bar_orientation only works on bar plots. Skipping')
    return(p)
  }

  orientation <- match.arg(orientation)

  p$x$options$indexAxis <- ifelse(orientation == 'vertical', 'x', 'y')

  p

}



