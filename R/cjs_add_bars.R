#' Add a dataset to the chartjs bar chart
#'
#' Add a dataset to a chartjs instance
#'
#' @param p a chartjs htmlwidget
#' @param ... aesthetic parameters to pass on to chartjs chart types e.g. x, y, TODO, ...
#' @param label dataset title (used in legends)
#' @param data data from which aesthetic parameters are sourced. If NULL, that within
#' the chartjs htmlwidget is used.
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_add_bars <- function(p, ..., label = NULL, data = NULL){

  dots <- rlang::enquos(...)
  args_are_syms <- all(sapply(dots, rlang::quo_is_symbol))

  # # TODO Can this be made simpler?
  # if (is.null(data)) {
  #   if (args_are_syms){
  #     # is.null(data) & args_are_syms
  #     message('null data, using source')
  #     data <- p$x$source_data
  #     data_selected <- dplyr::select(data, !!!dots)
  #   } else {
  #     # is.null(data) & !args_are_syms
  #     message('vectors given')
  #     data_selected <- lapply(dots, rlang::eval_tidy)
  #   }
  # } else {
  #   # !is.null
  #   message('using given data')
  #   data_selected <- dplyr::select(data, !!!dots)
  # }
  #
  if (is.null(data) & args_are_syms) {
    data_selected <- dplyr::select( p$x$source_data, !!!dots)
  } else if (is.null(data) & !args_are_syms) {
    data_selected <- lapply(dots, rlang::eval_tidy)
  } else if (!is.null(data)) {
    data_selected <- dplyr::select(data, !!!dots)
  } else {
    stop('Something went wrong with cjs_add_bars and data selection')
  }

  current_type <- p$x$type
  current_labels <- p$x$data$labels
  # when there are no datasets "NULL" character returned
  current_y_class <- class(p$x$data$datasets[[1]]$data)

  x_class = class(data_selected$x)
  y_class = class(data_selected$y)

  #stopifnot('There is no data' = is.null(current_data) ... )
  stopifnot('Cannot yet add different chart types together' = is.null(current_type) | current_type == 'bar')
  stopifnot('New labels do not match current labels' = is.null(current_labels) | identical(current_labels, data_selected[['x']]))
  # Something to ponder ...
  #stopifnot('y data types to do not match' = current_y_class == 'NULL' | identical(current_y_class, y_class))

  if (is.null(current_type)) {
    p$x$type <- 'bar'
  }

  is_grouped <- 'group' %in% names(dots)

  if (is.null(current_labels)) {
    p$x$data$labels <- data_selected$x
  }

  datasets_length = length(p$x$data$datasets)
  new_dataset_ind <- datasets_length + 1

  label <- ifelse(is.null(label), paste('Dataset', new_dataset_ind), label)

  p$x$data$datasets[[new_dataset_ind]] <-
    list(data = data_selected$y,
         label = label)

  p
}
