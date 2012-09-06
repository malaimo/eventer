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

function keventer_events_list_handler() {
  $html_output = keventer_events_list();
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
    $html_output .= "['','".$event_date->format( 'd-M' )."',' Scrum - Gestión Ágil de Proyectos @ PMC College & Consulting','Asunción, Paraguay',''],";	
  }
  
  $html_output .= "];\n"
				. "-->\n"
				. "</script>";
  return $html_output;
}
?>