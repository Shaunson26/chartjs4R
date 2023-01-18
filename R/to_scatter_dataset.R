#' Convert xy to chartjs scatter data layout
#'
#' @param data a data.frame
#' @param grouped whether the data has a grouping variable in the column `group`
#'
#' @return list
to_scatter_dataset <- function(data, grouped = FALSE){

  to_scatter_data <- function(x){
    scatter_data <- apply(x, 1, as.list)
    unname(scatter_data)
  }

  if (grouped){

    datasets <-
      list(
        list(
          label = 'dataset 1',
          data = to_scatter_data(data[, c('x', 'y')])
        )
      )


  }


  if (grouped) {

    data_grouped <-
      dplyr::group_split(data, rlang::.data$group)

    datasets <-
      lapply(data_grouped, function(group_data){
        list(
          label = group_data$group[1],
          data = to_scatter_data(group_data[, c('x', 'y')])
        )
      })
  }

  datasets
}

