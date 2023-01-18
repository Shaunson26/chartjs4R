#' Scale Title Configuration
#' Namespace: `options.scales[scaleId].title`, it defines options for the scale title. Note that this only applies to cartesian axes.
#'
#' @param display boolean FALSE If true, display the axis title.
#' @param align string 'center' Alignment of the axis title. Possible options are 'start', 'center' and 'end'
#' @param text string|string[] '' The text for the title. (i.e. "# of People" or "Response Choices").
#' @param color Color Chart.defaults.color Color of label.
#' @param font Font Chart.defaults.font See Fonts
#' @param padding Padding 4 Padding to apply around scale labels. Only top, bottom and y are implemented.
#'
#' @return a list
cjs_cartesian_title <-
  function(display = FALSE,
           align = 'center',
           text = '',
           color = htmlwidgets::JS('Chart.defaults.color'),
           font = htmlwidgets::JS('Chart.defaults.font'),
           padding = 4){

    parameters <- as.list(environment())
    parameters$display <- ifelse(parameters$text != '', TRUE, FALSE)
    not_null_parameters <- !sapply(parameters, is.null)
    parameters[not_null_parameters]

  }
