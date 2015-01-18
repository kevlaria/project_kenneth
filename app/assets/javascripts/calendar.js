function populate_calendar(){
	$('#calendar').fullCalendar({
			header: {
				left: 'prev, next today',
				center: 'title',
				right: 'month, agendaWeek, agendaDay',
				},
			timezone: 'local',
			defaultDate: new Date(),
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			events: '/calendar/events.json',
			eventColor: '#828181',
			eventClick: function(event) {
        		if (event.url) {
	            	window.location = event.url;
    	        	return false;
        		}
    		}
    		
	});	
	
}