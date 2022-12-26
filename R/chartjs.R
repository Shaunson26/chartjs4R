#' Chartjs widget
#'
#' Basic Chartjs widget
#'
#' @param data data.frame with data
#' @param x,y column names from data
#' @param type chart type
#' @param width,height width and height in pixels (optional, defaults to automatic sizing)
#' @param elementId id of the widget created with this function
#'
#' @return An object of class `htmlwidget`
#'
#' @import htmlwidgets
#'
#' @export
chartjs <- function(data, x, y, type = 'bar', width = NULL, height = NULL, elementId = NULL) {

  data <-
    dplyr::select(
      data,
      x = {{ x }},
      y = {{ y }},
    )

  # forward options using x
  x = list(
    data = data,
    type = type
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'chartjs',
    x,
    width = width,
    height = height,
    package = 'chartjs',
    elementId = elementId
  )
}

chartjs_html <- function(...){
  htmltools::tags$div(
    htmltools::tags$canvas(...)
  )
}

#' Shiny bindings for chartjs
#'
#' Output and render functions for using chartjs within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a chartjs
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name chartjs-shiny
#'
#' @export
chartjsOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'chartjs', width, height, package = 'chartjs')
}

#' @rdname chartjs-shiny
#' @export
renderChartjs <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, chartjsOutput, env, quoted = TRUE)
}
