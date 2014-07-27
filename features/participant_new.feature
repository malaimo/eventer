Feature: Registración en evento

    @selenium
    Scenario: El formulario en inglés
        Given there is one event
        When I visit the "en" registration page
        Then I should see "More info!"

    @selenium
    Scenario: El formulario en español
        Given there is one event
        When I visit the "es" registration page
        Then I should see "¡Me interesa!"

    @selenium
    Scenario: El formulario en idioma desconocido default a Inglés
        Given there is one event
        When I visit the "xx" registration page
        Then I should see "More info!"

    @selenium
    Scenario: El formulario sin lenguaje indicado
        Given there is one event
        When I visit the registration page without languaje
        Then I should see "¡Me interesa!"

