function populate_calendar(){
	$('#calendar').fullCalendar({
			defaultDate: new Date(),
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			events: '/calendar/events.json',
			eventColor: '#D4D4D4',
			eventClick: function(event) {
        		if (event.url) {
	            	window.location = event.url;
    	        	return false;
        		}
    		}
    		
	});	
	
}