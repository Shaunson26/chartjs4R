#' data for list input example
#'
#' list input configuration for passing input 'as-is' to chartjs. Produces a
#' bar plot with 1 dataset.
#'
#' @return a list
#'
#' @export
list_input_example <- function(){
  list(
    type = "bar",
    data = list(
      labels = c(1, 2, 3, 4),
      datasets= list(
        list(
          label= "dataset 1",
          data= c(1, 4, 3, 2)
        )
      )
    ),
    options = list(
      maintainAspectRatio = FALSE,
      resizeDelay = 250
    )
  )
}
