Feature: Inicio

	Scenario: Página de Inicio
		Given I visit the home page
		Then I should see "Listado de eventos"
		And I should see "Fecha"
		And I should see "Nombre"
		And I should see "Ciudad"
		And I should see "País"

#	Scenario: Dashboard de Participantes
#		Given Im a logged in user
#		And theres 1 event 1 week away from now
#		And theres 1 event 2 week away from now
#		And theres 1 event 3 week away from now
#		And theres 1 event 4 week away from now
#		And theres 1 event 5 week away from now
#		And theres 1 event 6 week away from now
#		And theres 1 event 8 week away from now
#		When I visit the dashboard
#		Then I should see "Eventos a 1 semana(s)"
#		And I should see "Eventos a 2 semana(s)"
#		And I should see "Eventos a 4 semana(s)"
#		And I should see "Eventos a 6 semana(s)"
#		And I should see "Eventos a más de 6 semanas"
#		And I should not see "Eventos a 3 semana(s)"
#		And I should not see "Eventos a 5 semana(s)"
#		And I should not see "Eventos a 7 semana(s)"
	
#	@selenium
#	Scenario: Dashboard de Participantes
#		Given Im a logged in user
#		And I create a valid event of type "Tipo de Evento de Prueba"
#		And there are 3 participants and 1 is contacted 
#		When I visit the dashboard
#		Then I should see "2 nuevos"