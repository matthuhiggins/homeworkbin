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
      YAHOO.util.Event.on(allFields, 'focus', hideCalendar);
      YAHOO.util.Event.on(container, 'click', ignoreInsideClick);
      calendar.show();
    }

    function hideCalendar() {
      YAHOO.util.Event.removeListener(allFields, 'focus', hideCalendar);
      YAHOO.util.Event.removeListener(container, 'click', ignoreInsideClick);
      calendar.hide();
    }

    calendar.selectEvent.subscribe(handleCalendarSelect);
    YAHOO.util.Event.on(field, 'change', handleFieldChange);
    YAHOO.util.Event.on(field, 'focus', showCalendar);
    YAHOO.util.Event.on(field, 'click', showCalendar);
    YAHOO.util.Event.on(document, 'click', hideCalendar);
    
    calendar.render();    
  };
  
  return function(formId) {
    var dateSelectorEls = YAHOO.util.Dom.getElementsByClassName('date-selector', 'div', formId);
    for(var i = 0; i < dateSelectorEls.length; i++) {
      configureDateSelector(dateSelectorEls[i]);
    }
  };
})();