HW = {};

HW.dateSelector = (function() {
  var VALID_DATE = /^\s*\d{1,2}\/\d{1,2}\/\d{4}\s*$/;

  function fieldToCalendar(field, calendar) {
    if (VALID_DATE.test(field.value)) {
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

  function configureDateSelector(container) {
    var field = container.getElementsByTagName('input')[0],
        allFields = document.getElementsByTagName('input'),
        calendarEl = YAHOO.util.Dom.getElementsByClassName('calendar', 'div', container)[0],
        calendar = new YAHOO.widget.Calendar(calendarEl);

    fieldToCalendar(field, calendar);

    function handleCalendarSelect() {
      calendarToField(calendar, field);
      field.focus();
    }

    function handleFieldChange() {
      fieldToCalendar(field, calendar);
    }

    function ignoreInsideClick(e) {
      YAHOO.util.Event.stopEvent(e);
    }

    function showCalendar() {
      YAHOO.util.Event.addListener(allFields, 'focus', hideCalendar);
      YAHOO.util.Event.addListener(container, 'click', ignoreInsideClick);
      calendar.show();
    }

    function hideCalendar() {
      YAHOO.util.Event.removeListener(allFields, 'focus', hideCalendar);
      YAHOO.util.Event.removeListener(container, 'click', ignoreInsideClick);
      calendar.hide();
    }

    calendar.selectEvent.subscribe(handleCalendarSelect);
    YAHOO.util.Event.addListener(field, 'change', handleFieldChange);
    YAHOO.util.Event.addListener(field, 'focus', showCalendar);
    YAHOO.util.Event.addListener(field, 'click', showCalendar);
    YAHOO.util.Event.addListener(document, 'click', hideCalendar);
    
    calendar.render();    
  };
  
  return function(formId) {
    var dateSelectorEls = YAHOO.util.Dom.getElementsByClassName('date-selector', 'div', formId);
    for(var i = 0; i < dateSelectorEls.length; i++) {
      configureDateSelector(dateSelectorEls[i]);
    }
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