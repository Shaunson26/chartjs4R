#' Scale shape function
#'
#' Shape datasets within a chartjs object.
#'
#' @param p chartjs object
#' @param pointStyles vector of shapes. See `cjs_shapes` for options. Can be named to match the `labels`
#' in the datasets. A single unnamed value will shape all datasets. Uses `I()` if
#' you want points of all datasets a given value to avoid a warning message about
#' value mismatch to number of datasets
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_scale_shape <- function(p, pointStyles){

  if (p$x$type != 'scatter'){
    message('Can only add shapes to scatterplots')
    return(p)
  }

  if (inherits(pointStyles, 'AsIs') & length(pointStyles) > 1){
    warning("I() can only be used with 1 number")
    attr(pointStyles, 'AsIs') <- NULL
  }

  parameters <-
    list(
      pointStyle = pointStyles
    )

  n <-
    list(
      pointStyle = length(pointStyles),
      datasets = length(p$x$data$datasets)
    )

  input_has_names <- !is.null(names(pointStyles))
  which = 'pointStyle'

  # Accept a single value
  unnamed_multiple_inputs_n_mismatch <- !input_has_names & n[[which]] != 1 & n[[which]] != n$datasets
  named_inputs_n_mismatch <- input_has_names & n[[which]] != n$datasets

  if (unnamed_multiple_inputs_n_mismatch | named_inputs_n_mismatch){
    warning('The number of given ', which, ' does not match the number of datasets')
  }

  one_unnamed_input_multiple_datasets <- !input_has_names & n[[which]] == 1 & n$datasets > 1

  if (one_unnamed_input_multiple_datasets){
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
