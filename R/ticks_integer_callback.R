#' Callback function for cjs_ticks$callback
#'
#' The way ticks are produced in chartjs can require a function that determine when
#' and where they are drawn. This function is a simple callback to produce ticks at
#' given intervals (step).
#'
#' @param step the step value to compare the callback value to determine if a line
#' shoule be drawn
#'
#' @return a value with a JS_EVAL attribute
#'
#' @export
ticks_integer_callback <- function(step = 1){

  js_func <- 'function(value, index, ticks) { return value %% %s === 0 ? value : null;}'
  js_func <- sprintf(js_func, step)
  htmlwidgets::JS(js_func)
}
