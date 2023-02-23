#' Example data to test and showcase chartjs
#'
#' A function that generates data.frames for input. Scatter XY values use `runif(12)`
#'
#' @param type data for chart type: 'bar', 'scatter', so far ...
#' @param grouped whether to include a group column for multiple datasets/traces
#' @param shuffle whether to shuffle the data. Used in testing.
#'
#' @return a data.frame
#'
#' @export
cjs_example_data <- function(type = 'bar', grouped = FALSE, shuffle = FALSE){

  type = match.arg(type, choices = c('bar', 'scatter', 'doughnut_pie'))

  times <- if (grouped) 1:3 else 1

  if (type %in% c('bar', 'doughnut_pie')){

    bar_data <- function(i = 1){
      data.frame(letters = LETTERS[1:5],
                 numbers = stats::rpois(5, 5),
                 group = paste0('g', i))
    }

    out <- do.call(rbind.data.frame, lapply(times, function(i) bar_data(i)))

  }

  if (type == 'scatter'){

    scatter_data <- function(i){
      data.frame(x_numbers = stats::runif(12),
                 x_time = sample(seq.Date(Sys.Date() - 24, Sys.Date(), 'days'), size = 12),
                 y_numbers = stats::runif(12),
                 group = paste0('g', i))
    }

    out <- do.call(rbind.data.frame, lapply(times, function(i) scatter_data(i)))

  }

  if (shuffle){
    out <- out[sample(1:nrow(out)),]
  }

  out

}
