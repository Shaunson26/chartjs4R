#' dot input example
#'
#' list input configuration for passing input 'as-is' to chartjs
#'
#' @return a list
dots_input_example <- function(){
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
