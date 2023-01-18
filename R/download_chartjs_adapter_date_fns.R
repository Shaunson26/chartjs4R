#' Download Chartjs built files
#'
#' @description
#' Download built Chartjs files to package library `inst/htmlwidgets/lib/Chart.js-{version}`
#'
#' @param version version to download
#'
#' @return nothing
download_chartjs_adapter_date_fns <- function(version = '3.0.0'){

  dir =
    base::paste0('inst/htmlwidgets/lib/chartjs-adapter-date-fns-', version)

  base::dir.create(dir, recursive = TRUE)

  chartjs <-
    base::file.path(
      "https://cdn.jsdelivr.net",
      paste0("npm/chartjs-adapter-date-fns@", version),
      "dist/chartjs-adapter-date-fns.bundle.min.js"
    )

  utils::download.file(chartjs, destfile = file.path(dir,  "chartjs-adapter-date-fns.bundle.min.js"))
}
