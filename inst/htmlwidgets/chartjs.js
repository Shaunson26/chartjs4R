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

        // interactions
        if (x.return_data_ids){
          let xy_types = ['bar', 'scatter']
         if (xy_types.includes(x.type)) {
           //console.log('is bar or scatter')
            x.options.onClick = get_active_element_xy;
         }
        }
       // build
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

    Shiny.addCustomMessageHandler(
      type = "set-active-elements", function(x) {
        let chart = get_chartjs(x.id);
        // access something
        console.log(x.ActiveDataPoint)
        let el = chart.data.datasets[x.ActiveDataPoint.datasetIndex]
        //el.hoverBorderWidth = 5,
        //el.hoverBorderColor = 'green'
        chart.setActiveElements([x.ActiveDataPoint]);
        chart.update();
    });

};

// event handlers
function get_active_element_xy(evt, elements, chart) {

  // Examine docs for this
  const bars = chart.getElementsAtEventForMode(evt, "nearest", { intersect: true }, true);
  if (bars.length === 0) return; // no bars
  // Work with first element of bars
  const bar = bars[0];
  // Get index and label text
  // The label index .. for multiple bars, you'd get the same index for different
  // bars on top of say 'A'
  const index = bar.index;
  //const label = chart.data.labels[index];
  // Get clicked bar dataset index
  const datasetIndex = bar.datasetIndex;
  const value = chart.data.datasets[datasetIndex].data[index]
  //console.log(index, ' value in dataset ', datasetIndex, '... xy value: ', value);

  if (HTMLWidgets.shinyMode){

    let shiny_id = chart.canvas.parentNode.id;

    let inputValue = {
      index: index,
      datasetIndex: datasetIndex,
      x: value.x,
      y: value.y
    }

    Shiny.setInputValue(shiny_id + '_clicked', inputValue);
  }

}
