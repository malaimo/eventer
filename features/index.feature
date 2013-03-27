Feature: Inicio

	Scenario: Página de Inicio
		Given I visit the home page
		Then I should see "Listado de eventos"
		And I should see "Fecha"
		And I should see "Nombre"
		And I should see "Ciudad"
		And I should see "País"

	@selenium		
	Scenario: Dashboard de Participantes
		Given Im a logged in user
		And I create a valid event of type "Tipo de Evento de Prueba"
		And there are 3 participants and 1 is contacted 
		When I visit the dashboard
		Then I should see "2 nuevos"
		And I should see "1 contactados"