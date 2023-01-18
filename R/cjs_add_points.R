#' Add a dataset to the chartjs bar chart
#'
#' Add a dataset to a chartjs instance
#'
#' @param p a chartjs htmlwidget
#' @param ... aesthetic parameters to pass on to chartjs chart types e.g. x, y, TODO, ...
#' @param label dataset title (used in legends)
#' @param data data from which aesthetic parameters are sourced. If NULL, that within
#' the chartjs htmlwidget is used.
#' @param show_line boolean, whether to connect the points with a line
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_add_points <- function(p, ..., label = NULL, data = NULL, show_line = FALSE){

  dots <- rlang::enquos(...)
  args_are_syms <- all(sapply(dots, rlang::quo_is_symbol))

  if (is.null(data) & args_are_syms) {
    data_selected <- dplyr::select( p$x$source_data, !!!dots)
  } else if (is.null(data) & !args_are_syms) {
    data_selected <- lapply(dots, rlang::eval_tidy)
  } else if (!is.null(data)) {
    data_selected <- dplyr::select(data, !!!dots)
  } else {
    stop('Something went wrong with cjs_add_bars and data selection')
  }

  expected_type = 'scatter'
  current_type <- p$x$type
  # when there are no datasets "NULL" character returned
  current_x_class <- class(p$x$data$datasets[[1]]$data[[1]]$x)
  current_y_class <- class(p$x$data$datasets[[1]]$data[[1]]$y)

  x_class = class(data_selected$x)
  y_class = class(data_selected$y)

  #stopifnot('There is no data' = is.null(current_data) ... )
  stopifnot('Cannot yet add different chart types together' = is.null(current_type) | current_type == expected_type)
  # Something to ponder ...
  #stopifnot('y data types to do not match' = current_y_class == 'NULL' | identical(current_y_class, y_class))

  if (is.null(current_type)) {
    p$x$type <- expected_type
  }

  is_grouped <- 'group' %in% names(dots)

  datasets_length = length(p$x$data$datasets)
  datasets_length = length(p$x$data$datasets)
  new_dataset_ind <- datasets_length + 1

  label <- ifelse(is.null(label), paste('Dataset', new_dataset_ind), label)

  p$x$data$datasets[[datasets_length + 1]] <-
    list(data = apply(cbind(data_selected$x, data_selected$y), 1, as.list),
         label = label,
         showLine = show_line)

  p

}
