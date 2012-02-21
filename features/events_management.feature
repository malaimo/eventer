Feature: Administración de Eventos

	Scenario: Alta de Evento Válido
		Given Im a logged in user
		When I create a valid event named "Curso de Meteorología Básica I"
		Then I should be on the events listing page
		And I should see "Evento creado exitosamente"
		And I should see "Curso de Meteorología Básica I"
		
	Scenario: Validación de Fecha Pasada
		Given Im a logged in user
		When I create an invalid event with "23/01/2001" as "event_date"
		Then I should see "el evento debe tener una fecha futura"
	
	Scenario: Validación de Capacidad
		Given Im a logged in user
		When I create an invalid event with "0" as "event_capacity"
		Then I should see "el evento no puede tener una capacidad de 0 personas"
		
	Scenario: Precio SEB debe ser menor a Precio de Lista
		Given Im a logged in user
		When I create an invalid event with "1000" as "event_seb_price"
		Then I should see "el Precio Super Early Bird no puede ser mayor al Precio de Lista"

	Scenario: Precio EB debe ser menor a Precio de Lista
		Given Im a logged in user
		When I create an invalid event with "1000" as "event_eb_price"
		Then I should see "el Precio Early Bird no puede ser mayor al Precio de Lista"
		
	Scenario: Precio SEB debe ser menor al Precio EB
		Given Im a logged in user
		When I create an invalid event with "475" as "event_seb_price"
		Then I should see "el Precio Super Early Bird no puede ser mayor al Precio Early Bird"

	Scenario: Fecha SEB debe ser menor a la Fecha del Evento
		Given Im a logged in user
		When I create an invalid event with "31/01/3000" as "event_seb_end_date"
		Then I should see "la fecha de Super Early Bird no puede ser mayor a la Fecha del Evento"
		
	Scenario: Fecha EB debe ser menor a la Fecha del Evento
		Given Im a logged in user
		When I create an invalid event with "31/01/3000" as "event_eb_end_date"
		Then I should see "la fecha de Early Bird no puede ser mayor a la Fecha del Evento"

	Scenario: Fecha SEB debe ser menor a la Fecha EB
		Given Im a logged in user
		When I create an invalid event with "31/01/2250" as "event_seb_end_date"
		Then I should see "la fecha de Super Early Bird no puede ser mayor a la Fecha de Early Bird"
		
	Scenario: Un evento Privado no debe tener descuentos
		Given Im a logged in user
		When I create an private event with discounts
		Then I should see "un evento Privado no puede tener descuentos por cantidad de personas"
		
	Scenario: No se puede crear un evento vacío
		Given Im a logged in user
		When I create an empty event
		Then I should see "Por favor verifica los campos destacados"
		And  I should see "no puede estar en blanco"
	
	@selenium	
	Scenario: Se deben ocutar los descuentos y precios EB y SEB si es un evento privado
		Given Im a logged in user
		When I choose to create a Private event
		Then I should not see public prices
	
	@selenium
	Scenario: Se deben mostrar los descuentos y precios EB y SEB si es un evento público
	    Given Im a logged in user
		When I choose to create a Public event
		Then I should see public prices
	
		