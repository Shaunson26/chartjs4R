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
