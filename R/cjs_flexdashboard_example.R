#' Show flexdashboard chartjs example
#'
#' Show flexdashboard example of chartjs. File path of the Rmd is messaged to the
#' console.
#'
#' @import flexdashboard
#'
#' @export
#' @return rendered HTML
cjs_flexdashboard_example <- function(){
  file <- system.file(package = 'chartjs4r', 'flexdashboard-example/flexdashboard-example.Rmd')
  message('Example Rmd found here: ', file)
  tmp_file <- tempfile(fileext = '.html')
  rmarkdown::render(file, output_file = tmp_file, quiet = TRUE)
  utils::browseURL(tmp_file)
}
