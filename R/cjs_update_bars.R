#' Update chartjs proxy object
#'
#' Currently just replaces labels and `datasets[0].data`
#'
#' @param proxy `chartjsProxy()` object
#' @param data data.frame
#' @param x x values
#' @param y y values
#'
#' @export
#'
#' @return `chartjsProxy()` object
cjs_update_bars <- function(proxy, data, x, y){

  data <-
    dplyr::select(
      data,
      x = {{ x }},
      y = {{ y }},
    )
  message <- list(id = proxy$id, data = data)

  if (proxy$deferUntilFlush){
    proxy$session$onFlushed(once=TRUE, function(){
      proxy$session$sendCustomMessage("update-bars", message)
    })
  } else {
    proxy$session$sendCustomMessage("update-bars", message)
  }

  invisible(proxy)

}
