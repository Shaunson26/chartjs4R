add_lines <- function(p, x = NULL, y = NULL, label = NULL){

  stopifnot('x and y must be numeric' = is.numeric(x) & is.numeric(y))

  current_type <- p$x$type
  current_labels <- p$x$data$labels

  stopifnot('type error' = is.null(current_type) | current_type == 'bar')
  stopifnot('x error' = is.null(current_labels) | identical(current_labels, x))

  if (is.null(current_type)) {
    p$x$type <- 'line'
  }

  x_order = order(x)

  if (is.null(current_labels)) {
    p$x$data$labels <- x[x_order]
  }

  datasets_length = length(p$x$data$datasets)

  p$x$data$datasets[[datasets_length + 1]] <-
    list(data = y[x_order],
         label = label)

  p
}
