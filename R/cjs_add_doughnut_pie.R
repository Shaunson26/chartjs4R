#' Add a dataset to a chartjs doughnut/pie
#'
#' Add a dataset to a chartjs instance
#'
#' @param p a chartjs htmlwidget
#' @param type which of doughnut', 'pie' wanted
#' @param ... aesthetic parameters to pass on to chartjs chart types e.g. x, y, colors, TODO, ...
#' @param label dataset title (used in legends)
#' @param data data from which aesthetic parameters are sourced. If NULL, that within
#' the chartjs htmlwidget is used.
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_add_doughnut_pie <- function(p, type = c('doughnut', 'pie'), ..., label = NULL, data = NULL){

  expected_type = match.arg(type)
  current_type <- p$x$type
  current_labels <- p$x$data$labels

  stopifnot('Cannot yet add different chart types together' = is.null(current_type) | current_type == expected_type)

  dots <- rlang::enquos(...)

  data_selected <-
    select_data_from_correct_source(p, data = data, dots_quo = dots)

  if (is.null(current_type)) {
    p$x$type <- expected_type
  }

  is_grouped <- 'group' %in% names(dots)

  if (is.null(current_labels)) {
    p$x$data$labels <- data_selected$x
  }

  new_dataset <-
    list(data = data_selected$y)

  new_dataset_ind <- return_new_dataset_ind(p)

  new_dataset$label <- ifelse(is.null(label), paste('Dataset', new_dataset_ind), label)

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
