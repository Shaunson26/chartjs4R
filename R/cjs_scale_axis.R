#' Edit the scale of the plot
#'
#' Common options to all axes. Namespace: options.scales|scaleId| Note: depending
#' on the axis type used, there will be more options. See `cjs_scale_*` functions.
#' `border`, `grid` and `ticks` are themselves lists of options
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
#' @return An object of class `htmlwidget`
#'
#' @export
cjs_scale_axis <-
  function(p,
           id,
           type = NULL,
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
           weight = 0){

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


