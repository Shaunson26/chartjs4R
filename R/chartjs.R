#' Chartjs widget
#'
#' Basic Chartjs widget
#'
#' @param data Can be one of: a data.frame, SharedData or list of chartjs options (for a list,
#' see \href{https://www.chartjs.org/docs/latest/getting-started/usage.html}{chartjs usage}).
#' @param ... aesthetic parameters to pass on to chartjs chart types e.g. x, y, TODO, ...
#' @param type chartjs type - 'bar', 'scatter', TODO (the others!)
#' @param width,height width and height in pixels (optional, defaults to automatic sizing)
#' @param elementId id of the widget created with this function
#'
#' @return An object of class `htmlwidget`
#'
#' @import htmlwidgets
#'
#' @export
chartjs <- function(data = data.frame(), ..., type = NULL, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  # assume full list of options if dots is length 1
  # if (...length() == 1){
  #   x = list(...)[[1]]
  # } else {
  #   x = list(...)
  # }

  if (!is.data.frame(data) && !crosstalk::is.SharedData(data) && !is.list(data)) {
    stop("First argument, `data`, must be a data frame, shared data, or list", call. = FALSE)
  }

  stopifnot("type can be only one of: 'bar', 'scatter'" = is.null(type) | type %in% c('bar', 'scatter'))

  # "native" arguments
  if (is.list(data)) {
    x <- data
  }

  if (is.data.frame(data) || crosstalk::is.SharedData(data)) {

    x <- list()
    x$source_data = data
    x$type = type

    dots <- rlang::enquos(...)

    # build chart here
    if (any(c('x', 'y', 'group') %in% names(dots))){

      # data prep
      # create x,y,group dataset
      data_selected <- dplyr::select(data, !!!dots)
      is_grouped <- 'group' %in% names(dots)
      x_class = class(data_selected$x)
      y_class = class(data_selected$y)

      # TODO type guesser
      if (is.null(type)){

      }

      x$data <-
        arrange_data(data_selected, type = type)

      if (any(x_class %in% c('POSIXct', 'POSIXt', 'Date'))){
        x$options$scales[['x']] <- list(type = 'time')
      }

      if (any(y_class %in% c('POSIXct', 'POSIXt', 'Date'))){
        x$options$scales[['y']] <- list(type = 'time')
      }

    }
  }

  # create widget
  htmlwidgets::createWidget(
    name = 'chartjs',
    x,
    width = width,
    height = height,
    package = 'chartjs',
    elementId = elementId,
    sizingPolicy = htmlwidgets::sizingPolicy(
      padding = 0,
      browser.fill = TRUE,
      knitr.defaultWidth = '100%'
    )
  )
}

chartjs_html <- function(id, style, class, ...){
  htmltools::tags$div(id = id,
                      class = class,
                      style = style,
                      htmltools::tags$canvas()
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
