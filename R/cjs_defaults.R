#' Set chartjs defaults
#'
#' Set global defaults for subsequent chartjs objects in a document. To check
#' available options, create a chartjs plot, examine in the browser, go to the
#' javascript console and print the object "Chart.defaults".
#'
#' @param ... default options.
#'
#' @export
cjs_defaults <- function(...){

  # Capture arguments
  parameters <- list(...)
  parameters <- get_non_null_parameters(parameters)
  parameters <- relist_parameter_vector(parameters)

  update_obj = jsonlite::toJSON(parameters, auto_unbox = T)


  htmltools::singleton(
    htmltools::tags$script(
      htmltools::HTML(
        "updateObjectInPlace(Chart.defaults,", update_obj, ");"
      )
    )
  )

}




