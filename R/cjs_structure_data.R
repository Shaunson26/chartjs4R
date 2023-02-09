#' Structure an R data.frame into a chartjs data structure based on type
#'
#' Different chartjs data structures exist
#'
#' @param data data.frame with columns x, y, TODO ..
#' @param type chartjs type
cjs_structure_data <- function(data, type){

  as_y <- function(data){
    data[['y']]
  }

  format_data <- switch(type,
                          bar =,
                          scatter = data_to_xy_list,
                          doughnut =,
                          pie = as_y)

  has_no_group <- !('group' %in% names(data))

  if (has_no_group) {
    data$group <- NA
  }

  datasets <-
    data %>%
    dplyr::group_split(.data$group) %>%
    lapply(function(group_data){
      list(
        label = group_data$group[1],
        data = format_data(group_data)
      )
    })

chartjs_data_obj <-
  list(
    datasets = datasets
  )

if (type %in% c('bar', 'doughnut', 'pie')){
  # factor checking?
  chartjs_data_obj$labels = sort(unique(data$x))
}

chartjs_data_obj

}


