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

  base::dir.create(dir, recursive = TRUE, showWarnings = FALSE)

  chartjs_cdn <- function(base, version){
    base::file.path(
      "https://cdnjs.cloudflare.com/ajax",
      "libs/Chart.js",
      version,
      base
    )
  }

  files <-
    c(#'chart.umd.js',
      'chart.umd.min.js'
      #, 'chart.umd.js.map', 'helpers.js', 'helpers.js.map', 'helpers.min.js'
    )

  for(file in files){
    utils::download.file(chartjs_cdn(file, version = version), destfile = file.path(dir,  file))
  }

}

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
