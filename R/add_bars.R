add_bars <- function(p, x = NULL, y = NULL, label = NULL){

  current_type <- p$x$type
  current_labels <- p$x$data$labels

  stopifnot('type error' = is.null(current_type) | current_type == 'bar')
  stopifnot('x error' = is.null(current_labels) | identical(current_labels, x))

  if (is.null(current_type)) {
    p$x$type <- 'bar'
  }

  if (is.null(current_labels)) {
    p$x$data$labels <- x
  }

  datasets_length = length(p$x$data$datasets)

  p$x$data$datasets[[datasets_length + 1]] <-
    list(data = y,
         label = label)

  p
}
