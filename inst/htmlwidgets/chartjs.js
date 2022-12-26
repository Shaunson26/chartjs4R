HTMLWidgets.widget({

  name: 'chartjs',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        console.log(x)

        new Chart(el,
        {
          type: x.type,
          data: {
            labels: x.data.x,
            datasets: [
              {
                label: 'COMPLETE_ME',
                data: x.data.y
              }
            ]
          }
        }
        );
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
