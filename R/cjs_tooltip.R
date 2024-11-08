#' Modify tooltips
#'
#' Uses a callback function within chartjs. Reference elements using template literal
#' notation e.g. 'x value: $\{x\}, y value: $\{y\}'.
#' See `vignette('tooltips-and-interaction-modes', package = 'chartjs4r')`
#'
#' @param p chartjs object
#' @param title = 'title_text'
#' @param label =
#' @param beforeTitle = 'beforeTitle_text'
#' @param afterTitle = 'afterTitle_text'
#' @param footer = 'footer_text',
#' @param beforeFooter = 'beforeFooter_text'
#' @param afterFooter = 'afterFooter_text'
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_tooltip <- function(p, label, title, beforeTitle, afterTitle,
                        footer, beforeFooter, afterFooter){

  parameters <- as.list(environment())
  parameters <- get_non_null_parameters(parameters)

  # interaction mode

  tooltip_callbacks <- list()

  for(i in seq_along(parameters)){

    x <- parameters[[i]]
    x <- convert_template_literals(x)

    needs_map <-
      names(parameters)[i] %in% 'title' &
      grepl('[\\$\\{\\}]', x)

    if (needs_map) {
      tooltip_callbacks[[i]] <-
        htmlwidgets::JS(sprintf('function(e){ let text = e.map(e => { return (%s) })[0]; return text }', x))
    } else {
      tooltip_callbacks[[i]] <-
        htmlwidgets::JS(sprintf('function(e){ return (%s) }', x))
    }
  }

  names(tooltip_callbacks) <- names(parameters)

  p$x$options$plugins$tooltip <-
    list(enabled = TRUE,
         callbacks = tooltip_callbacks)

  p

}
