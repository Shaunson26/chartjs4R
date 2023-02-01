#' Cartesian (continuous) scale options
#'
#' Common options to all cartesian axes. Namespace: `options.scales[scaleId]`.
#' Datetimes require an addition plugin for `chartjs`, and `chartjs-adapter-date-fns`
#' is included in this package (https://github.com/chartjs/chartjs-adapter-date-fns),
#' which comes from `https://date-fns.org/` https://date-fns.org/v2.29.3/docs/format
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
#' @param adapters.date object {} Options for adapter for external date library if that adapter needs or supports options
#'
#' @param bounds string 'data' Determines the scale bounds. more...
#' @param offsetAfterAutoskip boolean FALSE If true, bar chart offsets are computed with auto skipped ticks.
#' @param ticks.source string 'auto' How ticks are generated. more...
#' @param time.displayFormats object  Sets how different time units are displayed. more...
#' @param time.isoWeekday boolean|number FALSE If boolean and true and the unit is set to 'week', then the first day of the week will be Monday. Otherwise, it will be Sunday. If number, the index of the first day of the week (0 - Sunday, 6 - Saturday)
#' @param time.parser string|function  Custom parser for dates. more...
#' @param time.round string FALSE If defined, dates will be rounded to the start of this unit. See Time Units below for the allowed units.
#' @param time.tooltipFormat string  The format string to use for the tooltip.
#' @param time.unit string FALSE If defined, will force the unit to be a certain type. See Time Units section below for details.
#' @param time.minUnit string 'millisecond' The minimum display format to be used for a time unit.
#'
#' @export
cjs_scale_time <-
  function(p, id,
           # generic
           type = 'time',
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
           offset = TRUE,
           title.text = '',
           title.display = FALSE,
           title.align = 'center',
           title.color = htmlwidgets::JS('Chart.defaults.color'),
           title.font = htmlwidgets::JS('Chart.defaults.font'),
           title.padding = 4,
           adapters.date = NULL, # check
           #bounds = 'data',
           offsetAfterAutoskip = FALSE,
           ticks.source = 'auto',
           time.displayFormats = NULL,
           time.isoWeekday = FALSE,
           time.parser = NULL,
           time.round = FALSE,
           time.tooltipFormat = NULL,
           time.unit = FALSE,
           time.minUnit = 'millisecond'){

    check_scale_axis_inputs(environment())

    # Fix logic
    type = 'time'

    if (is.character(time.unit)) {
      stopifnot(time.unit %in% c('millisecond', 'second', 'minute', 'hour', 'day',
                                 'week', 'month', 'quarter', 'year'))
      # chartjs expects another list for display formats of each time unit. We just
      # create one with a single value of that used
      if (!(is.null(time.displayFormats)) & !is.list(time.displayFormats)) {
        time.displayFormats <- list(time.displayFormats)
        names(time.displayFormats) <- time.unit
      }
    }

    if(title.text != ''){
      title.display = TRUE
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

# cjs_time_displayFormats <- function(){
#   list(
#     millisecond
#     second
#     minute
#     hour
#     day
#     week
#     month
#     quarter
#     year
#   )
# }
