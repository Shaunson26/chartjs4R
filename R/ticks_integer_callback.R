ticks_integer_callback <- function(jump = 1){

  js_func <- 'function(value, index, ticks) { return value %% %s === 0 ? value : null;}'
  js_func <- sprintf(js_func, jump)
  htmlwidgets::JS(js_func)
}
