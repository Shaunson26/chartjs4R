HTMLWidgets.widget({

  name: 'chartjs',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    // el is the div with a canvas tag
    let canvas = el.querySelector('canvas');
    console.log('meow');

    /*const canvasBackgroundColor = {
      id: 'canvasBackgroundColor',
      beforeDraw: (chart, args, options) => {
        const {ctx} = chart;
        ctx.save();
        ctx.globalCompositeOperation = 'destination-over';
        ctx.fillStyle = options.color || '#ffffff00';
        ctx.fillRect(0, 0, chart.width, chart.height);
        ctx.restore();
        }
    };*/


    return {

      renderValue: function(x) {

        /*Chart.defaults.color = 'blue';*/
        /*x.plugins = [canvasBackgroundColor]*/
        console.log('return');

        new Chart(canvas, x);

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size
        Chart.getChart(canvas).resize()
      }

    };
  }
});
