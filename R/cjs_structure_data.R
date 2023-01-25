#' Structure an R data.frame into a chartjs data structure based on type
#'
#' Different chartjs data structures exist
#'
#' @param data data.frame with columns x, y, TODO ..
#' @param type chartjs type
cjs_structure_data <- function(data, type){

  to_scatter_data <- function(data){
    output_data <- apply(data[, c('x', 'y')], 1, as.list)
    unname(output_data)
  }

  to_bar_data <- function(data){
    data[['y']]
  }

  data_arranger <- switch(type,
                          scatter = to_scatter_data,
                          doughnut =,
                          pie =,
                          bar = to_bar_data)

  labeller <- switch(type,
                     scatter = NULL,
                     doughnut =,
                     pie =,
                     bar = data[['x']])

  labels = labeller

  datasets <-
    list(
      list(
        label = 'dataset 1',
        data = data_arranger(data)
      )
    )

  list(
    labels = labels,
    datasets = datasets
  )

  # if (grouped) {
  #
  #   data_grouped <-
  #     dplyr::group_split(data, group)
  #
  #   datasets <-
  #     lapply(data_grouped, function(group_data){
  #       list(
  #         label = group_data$group[1],
  #         data = data_arranger(group_data)
  #       )
  #     })
  # }
  #
  # datasets

}
