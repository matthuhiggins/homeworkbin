HW = {};

HW.dateSelector = (function() {
  var calendars = [];

  function fieldToCalendar(field, calendar) {
    if (field.value != "") { 
      calendar.select(field.value); 
      var date = calendar.getSelectedDates()[0]; 
      if (date != null) {
        calendar.cfg.setProperty("pagedate", (date.getMonth() + 1) + "/" + date.getFullYear());
        calendar.render(); 
      }
    }
  }

  function calendarToField(calendar, field) {
    var date = calendar.getSelectedDates()[0];
    field.value = (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear();     
  }

  return function(containerId) {
    var field = document.getElementById(containerId).getElementsByTagName('input')[0],
        calendarEl = YAHOO.util.Dom.getElementsByClassName('calendar', 'div', containerId)[0],
        calendar = new YAHOO.widget.Calendar(calendarEl);

    fieldToCalendar(field, calendar);

    function handleCalendarSelect() {
      calendarToField(calendar, field);
      calendar.hide();
      YAHOO.util.Event.removeListener(field, "focus", handleFieldFocus);
      field.focus();
      YAHOO.util.Event.addListener(field, "focus", handleFieldFocus);
    }

    function handleFieldChange() {
      fieldToCalendar(field, calendar);
    }

    function handleFieldFocus() {
      for (var i = 0; i < calendars.length; i++) {
        calendars[i].hide();
      }
      calendar.show();
    }

    calendar.selectEvent.subscribe(handleCalendarSelect);
    YAHOO.util.Event.addListener(field, "change", handleFieldChange);
    YAHOO.util.Event.addListener(field, "focus", handleFieldFocus);
    YAHOO.util.Event.addListener(field, "click", handleFieldFocus);
    YAHOO.util.Event.addListener(containerId, "click", function(e) {
      YAHOO.util.Event. stopEvent(e);
    });
    YAHOO.util.Event.addListener(document, "click", calendar.hide, calendar, true);

    calendars.push(calendar);
    calendar.render();    
  };
})();

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