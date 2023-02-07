HTMLWidgets.widget({

  name: 'chartjs',

  type: 'output',

  factory: function(el, width, height) {

    // el is the div with a canvas tag
    let canvas = el.querySelector('canvas');

    return {

      renderValue: function(x) {

        let previous_instance = Chart.getChart(canvas.id)

        if (previous_instance){
          previous_instance.destroy();
        }

        new Chart(canvas, x);

      },

      resize: function(width, height) {

        Chart.getChart(canvas).resize()
      },

      getChart: function(){
        return Chart.getChart(canvas.id);
      }

    };
  }
});


function get_chartjs(id){
  let widget = HTMLWidgets.find("#" + id);
  let chart = widget.getChart();
  return chart;
}

// Add shiny handlers
if (HTMLWidgets.shinyMode){

  Shiny.addCustomMessageHandler(
    type = "update-bars", function(message) {
      let chart = get_chartjs(message.id);
      chart.data.labels = message.data.x;
      chart.data.datasets[0] = { data: message.data.y }
      chart.update();
    });

};
