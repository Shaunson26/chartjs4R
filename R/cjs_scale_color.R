cjs_scale_color <- function(p, backgroundColors, borderColors, match_background_and_border = FALSE){

  if (missing(borderColors)){
    borderColors = NULL
  }

  if (match_background_and_border){
    borderColors <- backgroundColors
  }

  colors <-
    list(
      backgroundColor = backgroundColors,
      borderColor = borderColors
    )

  n <-
    list(
      backgroundColor = length(backgroundColors),
      borderColor = length(borderColors),
      datasets = length(p$x$data$datasets)
    )

  add_colors <- function(p, which){

    if (is.null(colors[[which]])) return(p)

    colors_have_names <- !is.null(names(colors[[which]]))

    # Accept a single value
    unnamed_multiple_colours_n_mismatch <- !colors_have_names & n[[which]] != 1 & n[[which]] != n$datasets
    named_colours_n_mismatch <- colors_have_names & n[[which]] != n$datasets

    if (unnamed_multiple_colours_n_mismatch | named_colours_n_mismatch){
      warning('The number of given ', which, ' does not match the number of datasets')
    }

    one_unnamed_colour_multiple_datasets <- !colors_have_names & n[[which]] == 1 & n$datasets > 1

    if (one_unnamed_colour_multiple_datasets){
      warning('Only one unnamed ', which, ' was provided and multiple datasets exist. They will all be the same colour. Not sure this is what you want?')
    }

    if (colors_have_names) {

      dataset_labels <- sapply(p$x$data$datasets, function(x) x$label)
      dataset_labels <- sapply(p$x$data$datasets, function(x) x$label)
      all_names_match <- identical(sort(names(colors[[which]])), sort(dataset_labels))

      for (i in seq_along(dataset_labels)){
        if (is.na(colors[[which]][dataset_labels[i]])) next
        p$x$data$datasets[[i]][[which]] = unname(colors[[which]][dataset_labels[i]])
      }

    } else {
      for (i in seq_along(p$x$data$datasets)){
        if (length(colors[[which]]) == 1){
          p$x$data$datasets[[i]][[which]] = colors[[which]][1]
        } else {
          p$x$data$datasets[[i]][[which]] = colors[[which]][i]
        }
      }
    }
    p
  }

  p <- add_colors(p, 'backgroundColor')
  p <- add_colors(p, 'borderColor')
  p

  # # select given colours by names
  # if (colors_have_names) {
  #
  #   dataset_labels <- sapply(p$x$data$datasets, function(x) x$label)
  #
  #   all_names_match <- identical(sort(names(backgroundColors)), sort(dataset_labels))
  #
  #   if (!all_names_match){
  #     warning('Color names and dataset labels do not completely match. Please check')
  #   }
  #
  #   backgroundColors <- backgroundColors[dataset_labels]
  #
  #   aa <- 1:4; names(aa) <- letters[1:4]
  #   bb <- letters[c(1,2,4,5)]
  #   aa[bb]
  #
  # }
  #
  # for (i in seq_along(backgroundColors)){
  #   if (i > n_datasets) break
  #   p$x$data$datasets[[i]]$backgroundColor = backgroundColors[i]
  # }

}
