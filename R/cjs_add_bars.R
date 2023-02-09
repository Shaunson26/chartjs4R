#' Add a dataset to the chartjs bar chart
#'
#' Add a dataset to a chartjs instance
#'
#' @param p a chartjs htmlwidget
#' @param ... aesthetic parameters to pass on to chartjs chart types e.g. x, y, colors, TODO, ...
#' @param label dataset title (used in legends)
#' @param data data from which aesthetic parameters are sourced. If NULL, that within
#' the chartjs htmlwidget is used.
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_add_bars <- function(p, ..., label = NULL, data = NULL){

  # Check type
  expected_type = 'bar'
  current_type <- p$x$type
  stopifnot('Cannot yet add different chart types together' = is.null(current_type) | current_type == expected_type)

  if (is.null(current_type)) {
    p$x$type <- 'bar'
  }

  # Build data
  # TODO check aes in dots
  dots <- rlang::enquos(...)

  data_selected <-
    select_data_from_correct_source(p, data = data, dots_quo = dots)

  new_labels <- data_selected$x
  x_class = class(data_selected$x)
  y_class = class(data_selected$y)

  # when there are no datasets "NULL" character returned
  current_labels <- p$x$data$labels
  current_y_class <- class(p$x$data$datasets[[1]]$data)

  #stopifnot('New labels do not match current labels' = is.null(current_labels) | all(new_labels %in% current_labels))
  # Something to ponder ...
  #stopifnot('y data types to do not match' = current_y_class == 'NULL' | identical(current_y_class, y_class))

  # TODO factors
  if (is.null(current_labels)) {
    p$x$data$labels <- new_labels
  } else {
    p$x$data$labels <- c(p$x$data$labels, new_labels)
  }

  p$x$data$labels <- sort(unique(p$x$data$labels))

  new_dataset_ind <- return_new_dataset_ind(p)

  new_dataset <-
    list(data = data_to_xy_list(data_selected),
         label = ifelse(is.null(label), paste('Dataset', new_dataset_ind), label))

  if (!is.null(dots$colors)){
    backgroundColor <- rlang::eval_tidy(dots$colors)
    if (length(backgroundColor) != length(data_selected$x)){
      stop('The number of colours does not match the number of groups')
    }
    new_dataset$backgroundColor <- backgroundColor
  }

  p$x$data$datasets[[new_dataset_ind]] <- new_dataset

  p
}
