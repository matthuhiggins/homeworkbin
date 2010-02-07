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

  return function(attribute) {
    var calendar = new YAHOO.widget.Calendar(attribute + '_calendar'),
        field = document.getElementById('course_' + attribute); 

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

    YAHOO.util.Event.addListener(attribute, "click", function(e) {
      YAHOO.util.Event. stopEvent(e);
    });
    YAHOO.util.Event.addListener(document, "click", calendar.hide, calendar, true);

    calendars.push(calendar);
    calendar.render();    
    handleFieldChange();
  };
})();