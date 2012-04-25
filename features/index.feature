Feature: Inicio

	Scenario: Página de Inicio
		Given I visit the home page
		Then I should see "Listado de eventos"
		And I should see "Fecha"
		And I should see "Nombre"
		And I should see "Ciudad"
		And I should see "País"