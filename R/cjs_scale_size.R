#' Scale size function
#'
#' Size datasets within a chartjs object.
#'
#' @param p chartjs object
#' @param pointRadii vector of sizes Can be named to match the `labels`
#' in the datasets. A single unnamed value will size all datasets. Uses `I()` if
#' you want points of all datasets a given value to avoid a warning message about
#' value mismatch to number of datasets
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_scale_size <- function(p, pointRadii = I(3)){

  if (p$x$type != 'scatter'){
    message('Can only add shapes to scatterplots')
    return(p)
  }

  if (inherits(pointRadii, 'AsIs') & length(pointRadii) > 1){
    warning("I() can only be used with 1 number")
    attr(pointRadii, 'AsIs') <- NULL
  }

  parameters <-
    list(
      pointRadius = pointRadii
    )

  n <-
    list(
      pointRadius = length(pointRadii),
      datasets = length(p$x$data$datasets)
    )

  input_has_names <- !is.null(names(pointRadii))
  which = 'pointRadius'

  # Accept a single value
  skip_warning = !(inherits(parameters[[which]], 'AsIs'))
  unnamed_multiple_inputs_n_mismatch <- !input_has_names & n[[which]] != 1 & n[[which]] != n$datasets
  named_inputs_n_mismatch <- input_has_names & n[[which]] != n$datasets

  if (unnamed_multiple_inputs_n_mismatch | named_inputs_n_mismatch){
    warning('The number of given ', which, ' does not match the number of datasets')
  }

  one_unnamed_input_multiple_datasets <- !input_has_names & n[[which]] == 1 & n$datasets > 1

  if (skip_warning & one_unnamed_input_multiple_datasets){
    warning('Only one unnamed ', which, ' was provided and multiple datasets exist. They will all be the same value Not sure this is what you want?')
  }

  if (input_has_names) {

    dataset_labels <- sapply(p$x$data$datasets, function(x) x$label)
    all_names_match <- identical(sort(names(parameters[[which]])), sort(dataset_labels))

    for (i in seq_along(dataset_labels)){
      if (is.na(parameters[[which]][dataset_labels[i]])) next
      p$x$data$datasets[[i]][[which]] = unname(parameters[[which]][dataset_labels[i]])
    }

  } else {
    for (i in seq_along(p$x$data$datasets)){
      if (length(parameters[[which]]) == 1){
        p$x$data$datasets[[i]][[which]] = parameters[[which]][1]
      } else {
        p$x$data$datasets[[i]][[which]] = parameters[[which]][i]
      }
    }
  }

  p
}
