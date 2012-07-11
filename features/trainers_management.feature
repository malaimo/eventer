Feature: Administración de Instructores

	Scenario: Alta de Instructor
		Given Im a logged in user
		When I create a valid trainer named "Carlos Peix"
		Then I should be on the trainers listing page
		And I should see "Entrenador creado exitosamente"
		And I should see "Carlos Peix"
	

	Scenario: Alta de Instructor con mini Bio
		Given Im a logged in user
		When I create a valid trainer named "Carlos Peix" and with bio "Gran instructor!"
		And I view the trainer "Carlos Peix"
		Then I should see "Gran instructor!"

