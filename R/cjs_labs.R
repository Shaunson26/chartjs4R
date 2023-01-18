cjs_labs <- function(p, x = NULL, y = NULL){

  # if not null
  p$x$options$scales[['x']]$title <-
    list(display = ifelse(is.null(x), FALSE, TRUE),
         text = x)

  p$x$options$scales[['y']]$title <-
    list(display = ifelse(is.null(y), FALSE, TRUE),
         text = y)

  p

}
