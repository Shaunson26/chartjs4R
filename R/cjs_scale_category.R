#' Cartesian (continuous) scale options
#'
#' Common options to all cartesian axes. Namespace: `options.scales[scaleId]`
#'
#' @param p plot
#' @param id axis id
#' @param type string Type of scale being employed. Custom scales can be created and registered with a string key. This allows changing the type of an axis for a chart.
#' @param alignToPixels boolean FALSE Align pixel values to device pixels.
#' @param backgroundColor Color Background color of the scale area.
#' @param border object Border configuration. See `cjs_border()`
#' @param display boolean|string TRUE Controls the axis global visibility (visible when true, hidden when false). When display: 'auto', the axis is visible only if at least one associated dataset is visible.
#' @param grid object Grid line configuration. See `cjs_grid()`
#' @param min number User defined minimum number for the scale, overrides minimum value from data. more...
#' @param max number User defined maximum number for the scale, overrides maximum value from data. more...
#' @param reverse boolean FALSE Reverse the scale.
#' @param stacked boolean|string FALSE Should the data be stacked. more...
#' @param suggestedMax number Adjustment used when calculating the maximum data value. more...
#' @param suggestedMin number Adjustment used when calculating the minimum data value. more...
#' @param ticks object Tick configuration. See `cjs_ticks()`
#' @param weight number 0 The weight used to sort the axis. Higher weights are further away from the chart area.
#'
#' @param bounds string 'ticks' Determines the scale bounds. more...
#' @param position string | object  Position of the axis. more...
#' @param stack string  Stack group. Axes at the same position with same stack are stacked.
#' @param stackWeight number 1 Weight of the scale in stack group. Used to determine the amount of allocated space for the scale within the group.
#' @param axis string  Which type of axis this is. Possible values are: 'x', 'y'. If not set, this is inferred from the first character of the ID which should be 'x' or 'y'.
#' @param offset boolean FALSE If true, extra space is added to the both edges and the axis is scaled to fit into the chart area. This is set to true for a bar chart by default.
#' @param title.text The text for the title. (i.e. "# of People" or "Response Choices").
#' @param title.display boolean, if title.text is something other than "" then this will be automatically set to TRUE
#' @param title.align Alignment of the axis title. Possible options are 'start', 'center' and 'end'
#' @param title.color color of label, defaults to htmlwidgets::JS('Chart.defaults.color'),
#' @param title.font color of the font, defaults to htmlwidgets::JS('Chart.defaults.font'),
#' @param title.padding Padding to apply around scale labels. Only top, bottom and y are implemented.
#'
#' @param labels labels for the axis
#'
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_scale_category <-
  function(p, id,
           # generic
           type = 'category',
           alignToPixels = FALSE,
           backgroundColor = NULL,
           border = cjs_border(),
           display = TRUE,
           grid = cjs_grid(),
           min = NULL,
           max = NULL,
           reverse = FALSE,
           stacked = FALSE,
           suggestedMax = NULL,
           suggestedMin = NULL,
           ticks = cjs_ticks(),
           weight = 0,
           # cartesian
           bounds = 'ticks',
           position = NULL, # todo
           stack = NULL,
           stackWeight = 1,
           axis = NULL,
           offset = FALSE,
           title.text = '',
           title.display = FALSE,
           title.align = 'center',
           title.color = htmlwidgets::JS('Chart.defaults.color'),
           title.font = htmlwidgets::JS('Chart.defaults.font'),
           title.padding = 4,
           # category
           labels = NULL
           ){

    # Fix logic
    type = 'category'

    if(title.text != ''){
      title.display = TRUE
    }

    if (!is.null(p$x$type) & p$x$type == 'bar') {
      offset <- TRUE
    }


    # Capture arguments
    parameters <- as.list(environment())
    parameters <- get_non_null_parameters(parameters)
    parameters <- relist_parameter_vector(parameters)

    # Update data
    p$x$options$scales[[id]] <-
      modify_list(p$x$options$scales[[id]], parameters)

    # Return plot
    p

  }
