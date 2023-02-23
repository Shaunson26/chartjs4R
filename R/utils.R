#' text finder
#'
#' Find text in function bodies
#'
#' @param x text to find
find_text <- function(x){
  zz <- list.files('R/', full.names = TRUE)

  mm <- sapply(zz, function(file){
    filelines <- readLines(file)
    any(grepl(x, filelines))
  })

  zz[mm]

}

#' Compare chartjs labels
#'
#' @param p chartjs object
#' @param labels vector of labels to compare
compare_labels <- function(p, labels){

  current_labels <- p$x$data$labels

  if (is.null(current_labels)) {
    current_labels <- extract_dataset_data(p, 'x', unique = TRUE)
  }

  label_mismatch <- !all(labels %in% current_labels)

  if (label_mismatch){
    warning('The given labels mismatch the labels in the datasets. There will be empty group in the plot.')
  }

  invisible(NULL)

}

#' Extract elements from chartjs datasets.data
#'
#' @param p chartjs object
#' @param element x or y, or other to select from dtasets.data
#' @param unique should the result unlist the element values and unique them?
#'
#' @return a list or vector
extract_dataset_data <- function(p, element, unique = FALSE){

  element_list <-
    lapply(p$x$data$datasets, function(d){
      sapply(d$data, function(d) d[[element]])
    })

  if (unique){
    return(unique(unlist(element_list)))
  }

  element_list

}

#' Convert tooltip template literals
#'
#' Match R string values to chartjs objects within template literals.
#' https://www.chartjs.org/docs/latest/configuration/tooltip.html#tooltip-item-context
#'
#' @param string a string, with or without template literals
convert_template_literals <- function(string){

  has_no_literal <- !grepl('[\\$\\{\\}]', string)


  if (has_no_literal){
    return(sprintf('"%s"', string))
  }

  regex_starts <- gregexpr('\\$\\{', text = string)[[1]]
  regex_ends <- gregexpr('\\}', text = string)[[1]]

  if (length(regex_starts) == 1 && regex_starts == -1){
    regex_starts = character(0)
  }

  if (length(regex_ends) == 1 && regex_ends == -1){
    regex_ends = character(0)
  }

  stopifnot(
    'There seems to be missing $, { or } in string provided' = length(regex_starts) != 0 & length(regex_ends) != 0,
    'There seems to be missing $, { or } in string provided' = length(regex_starts) == length(regex_ends))

  regex_inds <-
    cbind(
      start = regex_starts + 2,
      stop = regex_ends - 1
    )

  label_values <-
    apply(regex_inds, MARGIN = 1, function(row){
      subbed_values = substr(string, row[1], row[2])
      trimws(subbed_values)
    })

  # Current matching criteria .. works for barplots so far
  # TODO with other plots
  substitute_values <-
    sapply(label_values, function(label){
      if (label == 'x'){
        'e.label'
      } else if (label == 'y'){
        'e.formattedValue'
      } else {
        paste0('e.dataset.', label)
      }
    })

  for(x in names(substitute_values)){
    pattern <- sprintf("\\$\\{\\s{0,}%s\\s{0,}\\}", x)
    replacement <- sprintf("\\$\\{%s\\}", substitute_values[x])
    string <- sub(pattern, replacement, string)
  }

  sprintf("`%s`", string)

}

#' Wrangle data to xy list
#'
#' @param data data.frame with x,y columns
#'
#' @return list
data_to_xy_list <- function(data){
  lapply(1:nrow(data), function(i){
    list(x = data[['x']][i],
         y = data[['y']][i])
  })
}

#' Check scale_axis inputs
#'
#' @param env function environment, passed on using `environment`
#'
#' @return nothing, or an error
check_scale_axis_inputs <- function(env){
  with(env,
       stopifnot(
         'A chartjs object must come before this function' = !missing(p),
         'p must be of class chartjs' = inherits(p, 'chartjs'),
         'id must be one of x or y' = !missing(id),
         'id must be one of x or y' = id %in% c('x', 'y')
       )
  )
}


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
  not_null_parameters <- !sapply(parameters, function(p){ is.null(p) | rlang::is_missing(p)})
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
