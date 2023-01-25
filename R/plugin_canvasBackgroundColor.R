#' Canvas background colour chartjs plugin
#'
#' Create an option to colour the canvas background. The function produces a list
#' that will become an object within the plugins array `x$plugins[plugin]`. The id
#' will become the plugin name, and this fuction takes in a color parameter, thus
#' `x$options$plugins$canvasBackgroundColor$color <- "some colour"`. This is
#' accessed using `cjs_theme(chart.backgroundColor = ...)`
#'
#' @return a list
#'
#' @export
canvasBackgroundColor <- function(){
  list(
    id = 'canvasBackgroundColor',
    beforeDraw = JS(
      "(chart, args, options) => {
    const {ctx} = chart;
    ctx.save();
    ctx.globalCompositeOperation = 'destination-over';
    ctx.fillStyle = options.color || '#ffffff00';
    ctx.fillRect(0, 0, chart.width, chart.height);
    ctx.restore();
      }")
  )
}
