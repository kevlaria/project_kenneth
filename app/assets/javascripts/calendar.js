function populate_calendar(){
	$('#calendar').fullCalendar({
			defaultDate: new Date(),
			editable: true,
			eventLimit: true, // allow "more" link when too many events

			events: '/calendar/events.json',
			eventClick: function(event) {
        		if (event.url) {
            	window.open(event.url);
            	return false;
        		}
    		}
	});	
	
}