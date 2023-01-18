#' Alter chartjs attributes associated with theming
#'
#' Some text
#'
#' @param p a chartjs htmlwidget
#' @param chart.backgroundColor background color of the plot
#' @param chart.borderColor border color of the plot
#' @param chart.color text colour for the plot
#' @param title.text plot title
#' @param title.display display the plot. Will automatically be TRUE if title text something other than ''
#' @param title.align Alignment of the title. Options are: 'start', 'center', 'end'
#' @param title.color Color of label
#' @param title.padding Padding to apply around scale labels. Only top, bottom and y are implemented
#' @param legend.display display the legend
#' @param legend.position Position of the legend. Options are: 'top', 'left', 'bottom' 'right'
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_theme <- function(
    p,
    chart.backgroundColor = NULL,
    chart.borderColor = NULL,
    chart.color = NULL,
    title.text = NULL,
    title.display = FALSE,
    title.align = NULL,
    title.color = NULL,
    title.padding = NULL,
    legend.display = TRUE,
    legend.position = NULL){

  title.display <- ifelse(is.null(title.text), FALSE, TRUE)
  legend.display <- ifelse(legend.position == 'none', FALSE, legend.display)

  parameters <- as.list(environment())
  parameters <- get_non_null_parameters(parameters)
  parameters <- relist_parameter_vector(parameters)

  # TODO fix plug in naming
  p$x$options$plugins$canvasBackgroundColor$color <-
    parameters$chart$backgroundColor

  p$x$options$plugins$title <-
    modify_list(p$x$options$plugins$title, parameters$title)

  p$x$options$plugins$legend <-
    modify_list(p$x$options$plugins$legend, parameters$legend)

  p
}
