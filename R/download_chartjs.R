#' Download Chartjs built files
#'
#' @description
#' Download built Chartjs files to package library `inst/htmlwidgets/lib/Chart.js-{version}`
#'
#' @param version version to download
#'
#' @return nothing
download_chartjs <- function(version = '4.1.1'){

  dir =
    base::paste0('inst/htmlwidgets/lib/Chart.js-', version)

  base::dir.create(dir, recursive = TRUE)

  chartjs <-
    base::file.path(
      "https://cdnjs.cloudflare.com/ajax",
      "libs/Chart.js",
      version,
      "chart.umd.js"
    )

  utils::download.file(chartjs, destfile = file.path(dir,  "chart.umd.js"))
}
