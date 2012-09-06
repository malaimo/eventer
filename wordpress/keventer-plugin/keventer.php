<?php
/*
Plugin Name: Keventer Shortcodes
Plugin URI: --
Description: Lists Events & Event Details from Keventer API
Version: 0.1 BETA
Author: Martin Alaimo
Author URI: http://www.martinalaimo.com
*/

add_shortcode("keventer-event-list", "keventer_events_list_handler");
add_shortcode("keventer-event", "keventer_event_handler");

function keventer_events_list_handler() {
  $html_output = keventer_events_list();
  return $html_output;
}

function keventer_event_handler() {
  $event_id = getEventIDFromURI();
  $html_output = keventer_event($event_id);
  return $html_output;
}

function keventer_events_list() {
  $html_output = "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"display\" id=\"cursos\">"
				. "<thead>"
				. "</thead>"
	    		. "<tbody></tbody>"
				. "</table>"
				. "<script type=\"text/javascript\" src=\"/wp-content/datatable/media/js/complete.min.js\"/></script>"
				. "<script type=\"text/javascript\" src=\"/wp-content/datatable/media/js/jquery.dataTables.js\"></script>"
				. "<script type=\"text/javascript\" src=\"/wp-content/datatable/media/js/dt_cursos.js\"></script>"
				. "<script type=\"text/javascript\">\n"
				. "<!--\n"
				. "var aCursos = [";
   			
  $xml = simplexml_load_file('http://keventer.herokuapp.com/api/events.xml'); 
  
  foreach ($xml->event as $event) {
	$event_date = new DateTime($event->date);
    $html_output .= "['','".$event_date->format( 'd-M' )."','<a href=\"/entrenamos/evento/".$event->id."\">".$event->{'event-type'}->name."</a>','".$event->city.", ".$event->country->name."',''],";	
  }
  
  $html_output .= "];\n"
				. "-->\n"
				. "</script>";
  return $html_output;
}

function keventer_event($event_id) {
	$event = simplexml_load_file('http://keventer.herokuapp.com/api/events/'.$event_id.'.xml');
	$event_date = new DateTime($event->date);
  	$html_output = "<h1>".$event->{'event-type'}->name."</h1>"
				. "<p><strong>Fecha:</strong> ".$event_date->format( 'd-M' )."<br/>"
				. "<strong>Lugar:</strong> ".$event->city.", ".$event->country->name."<br/>"
				. "</p>"
				. "<h3>Descripción</h3>"
				. "<p>".nl2br($event->{'event-type'}->description)."</p>"
				. "<h3>Objetivo</h3>"
				. "<p>".nl2br($event->{'event-type'}->goal)."</p>"
				. "<h3>Destinado A</h3>"
				. "<p>".nl2br($event->{'event-type'}->recipients)."</p>"
				. "<h3>Agenda</h3>"
				. "<p>".nl2br($event->{'event-type'}->program)."</p>"	
				. "";
	return $html_output;
}

function getEventIDFromURI()
{
	return str_replace("/","",substr($_SERVER["REQUEST_URI"],strrpos($_SERVER["REQUEST_URI"],"/entrenamos/evento/")+strlen("/entrenamos/evento/")));
}
?>