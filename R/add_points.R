add_points <- function(p, x = NULL, y = NULL, label = NULL, show_line = FALSE){

  stopifnot('x and y must be numeric' = is.numeric(x) & is.numeric(y))

  current_type <- p$x$type
  #current_labels <- p$x$data$labels

  stopifnot('type error' = is.null(current_type) | current_type == 'bar')
  #stopifnot('x error' = is.null(current_labels) | identical(current_labels, x))

  if (is.null(current_type)) {
    p$x$type <- 'scatter'
  }

  # if (is.null(current_labels)) {
  #   p$x$data$labels <- x
  # }

  datasets_length = length(p$x$data$datasets)

  p$x$data$datasets[[datasets_length + 1]] <-
    list(data = apply(cbind(x,y), 1, function(e) list(x=unname(e[1]),y=unname(e[2]))),
         label = label,
         showLine = show_line)

  p
}
