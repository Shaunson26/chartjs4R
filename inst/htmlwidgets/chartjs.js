HTMLWidgets.widget({

  name: 'chartjs',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    // el is the div with a canvas tag
    let canvas = el.querySelector('canvas')

    return {

      renderValue: function(x) {

        new Chart(canvas, x);
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size
        Chart.getChart(canvas).resize()
      }

    };
  }
});
