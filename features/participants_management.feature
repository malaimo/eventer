Feature: Administración de Participantes

	Scenario: Form de registro
		Given theres an event
		Then It should have a registration page

	Scenario: Nueva inscripción Exitosa
		Given theres an event
		When I register for that event
		Then I should see a confirmation message