Feature: Administración de Participantes

	Scenario: Form de registro
		Given theres an event
		Then It should have a registration page
	
	Scenario: Nueva inscripción Exitosa
		Given theres an event
		And theres an influence zone
		When I register for that event
		Then I should see a confirmation message
		
	Scenario: inscripción en Blanco
		Given theres an event
		And theres an influence zone
		When I make a blank registration for that event
		Then I should see "Todos los campos son requeridos"		