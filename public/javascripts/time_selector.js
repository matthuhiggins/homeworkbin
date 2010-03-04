HW.timeSelector = (function() {
  function selectableHours() {
    var hours = [];
    for (var hour = 0; hour < 24; hour++) {
      var meridian = hour < 12 ? 'am' : 'pm',
          display_hour = hour % 12;

      if (display_hour == 0) {
        display_hour = 12;
      }

      hours.push(hour + ':' + '00' + meridian);
      hours.push(hour + ':' + '30' + meridian);
    }
    return hours;
  }
  
  return function(containerId) {
    var field = document.getElementById(containerId).getElementsByTagName('input')[0];
    var autoCompleteEl = YAHOO.util.Dom.getElementsByClassName('autocomplete', 'div', containerId)[0];

    var datum = new YAHOO.util.LocalDataSource(selectableHours());
    var autoComplete = new YAHOO.widget.AutoComplete(field, autoCompleteEl, datum);
  };
})();