#' Return the next dataset index
#'
#' @param p chartjs object
#'
#' @return a number
return_new_dataset_ind <- function(p){
  datasets_length = length(p$x$data$datasets)
  datasets_length + 1
}

#' Return data.frame given parent function arguments
#'
#' Used within add_* functions. Expect arguments passed on from there. Returns
#' a data.frame with x, y, ... to be used downstream
#'
#' @param p chartjs object
#' @param data data argument passed on from parent function
#' @param dots_quo enquos(...) passed on from parent function
#'
#' @return a data.frame
select_data_from_correct_source <- function(p, data, dots_quo){

  data_selector_vars <- c('x', 'y')

  dots_quo_data <- dots_quo[names(dots_quo) %in% data_selector_vars]

  args_are_syms <- all(sapply(dots_quo_data, rlang::quo_is_symbol))

  if(length(p$x$source_data) == 0 & is.null(data) & args_are_syms) {
    stop('No source data exists nor was data specified')
  } else if (is.null(data) & args_are_syms) {
    data_selected <- dplyr::select(p$x$source_data, !!!dots_quo_data)
  } else if (is.null(data) & !args_are_syms) {
    data_selected <- as.data.frame(lapply(dots_quo_data, rlang::eval_tidy))
  } else if (!is.null(data)) {
    data_selected <- dplyr::select(data, !!!dots_quo_data)
  } else {
    stop('Something went wrong with cjs_add_bars and data selection')
  }

  data_selected
}

#' Check plugins
#'
#' @param plugins a list of plugins to check
#'
#' @return nothing
check_plugins <- function(plugins){
  stopifnot('plugins must be a unnamed list of plugins' = inherits(plugins, 'list'))
  stopifnot('plugins should be wrapped in an unnamed list e.g. list(a_plugin()). "id" was found as the first element' = is.null(plugins$id))
  invisible(NULL)
}

#' Catpure non-null function parameters
#'
#' After capturing environment from function, return non-null elements. Also
#' exclude p and id, plot object and scale id (usually not needed here)
#'
#' @param parameters list captured from `as.list(environment())` in function call
#'
#' @return a list
get_non_null_parameters <- function(parameters){
  exclude_these <- !names(parameters) %in% c('p', 'id')
  parameters <- parameters[exclude_these]
  not_null_parameters <- !sapply(parameters, is.null)
  parameters[not_null_parameters]
}

#' Modify list
#'
#' wrapper for ModifyList, in case the initial list is NULL
#'
#' @param list a named list to modify
#' @param new_list a new named list to add to `list`
#'
#' @return a list
modify_list <- function(list, new_list){
  if (is.null(list)){
    new_list
  } else {
    utils::modifyList(list, new_list)
  }
}

#' Create nested list from vector of value using . in names
#'
#' Create nested list from vector of value using . in names, e.g. a.b -> a$b
#'
#' @param vector named vector with '.' delineating nesting
#'
#' @return a list
relist_parameter_vector <- function(vector){

  vector_names <- strsplit(names(vector), '.', fixed = T)

  res <- list()

  for (i in 1:length(vector)) {

    current_vector_names <- vector_names[[i]]

    for (j in length(current_vector_names):1) {

      if (j == length(current_vector_names)) {

        # if passing a list do no unname
        if (inherits(vector[[i]], 'list')) {
          out <- list(vector[[i]])
        } else {
          out <- list(unname(vector[[i]]))
        }

        names(out) <- current_vector_names[j]

      } else {

        out <- list(out)
        names(out) <- current_vector_names[j]

      }

    }

    res <- utils::modifyList(res, out)
    rm(out)
  }

  res
}
