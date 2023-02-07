#' Show Shiny chartjs example
#'
#' Show Shiny example of chartjs. File path of the Rmd is messaged to the
#' console.
#'
#' @export
#' @return rendered HTML
cjs_shiny_example <- function(){
  file <- system.file(package = 'chartjs4r', 'shiny-example/app.R')
  message('Example Rmd found here: ', file)
  shiny::runApp(file)
}
