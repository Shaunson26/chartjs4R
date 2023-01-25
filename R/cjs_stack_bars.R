#' Stack datasets to create a stacked barchart
#'
#' Stack datasets to create a stacked barchart. Namespace: `options.scales[scaleId].stacked`
#'
#' @param p a chartjs object
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_stack_bars <- function(p){

  if (is.null(p$x$type)){
    message('No chart type exists. Setting to bar')
    p$x$type = 'bar'
  }

  p$x$options$scales$x$stacked <- TRUE
  p$x$options$scales$y$stacked <- TRUE

  p

}

cjs_unstack_bars <- function(p){

  if (is.null(p$x$type)){
    message('No chart type exists. Setting to bar')
    p$type = 'bar'
  }

  p$x$options$scales$x$stacked <- FALSE
  p$x$options$scales$y$stacked <- FALSE

  p

}
