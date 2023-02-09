#' Add a dataset to the chartjs bar chart
#'
#' Add a dataset to a chartjs instance
#'
#' @param p a chartjs htmlwidget
#' @param ... aesthetic parameters to pass on to chartjs chart types e.g. x, y, TODO, ...
#' @param label dataset title (used in legends)
#' @param data data from which aesthetic parameters are sourced. If NULL, that within
#' the chartjs htmlwidget is used.
#' @param show_line boolean, whether to connect the points with a line. They will be
#' connected in the order they appear
#'
#' @importFrom rlang .data
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_add_points <- function(p, ..., label = NULL, data = NULL, show_line = FALSE){

  # Check type
  expected_type = 'scatter'
  current_type <- p$x$type
  stopifnot('Cannot yet add different chart types together' = is.null(current_type) | current_type == expected_type)

  if (is.null(current_type)) {
    p$x$type <- expected_type
  }

  # Build data
  # TODO check aes in dots
  dots <- rlang::enquos(...)

  data_selected <-
    select_data_from_correct_source(p, data = data, dots_quo = dots) %>%
    dplyr::arrange(.data$x)

  # when there are no datasets "NULL" character returned
  current_x_class <- class(p$x$data$datasets[[1]]$data[[1]]$x)
  current_y_class <- class(p$x$data$datasets[[1]]$data[[1]]$y)

  x_class = class(data_selected$x)
  y_class = class(data_selected$y)

  #stopifnot('There is no data' = is.null(current_data) ... )
  # Something to ponder ...
  #stopifnot('y data types to do not match' = current_y_class == 'NULL' | identical(current_y_class, y_class))

  new_dataset_ind <- return_new_dataset_ind(p)

  new_dataset <-
    list(data = data_to_xy_list(data_selected),
         label = ifelse(is.null(label), paste('Dataset', new_dataset_ind), label),
         showLine = show_line)

  p$x$data$datasets[[new_dataset_ind]] <-
    new_dataset

  p

}
