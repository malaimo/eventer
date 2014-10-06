Feature: Administración de Instructores

	Scenario: Alta de Instructor
		Given Im a logged in user
		When I create a valid trainer named "Carlos Peix"
		Then I should be on the trainers listing page
#		And I should see "Entrenador creado exitosamente"
		And I should see "Carlos Peix"
	

	Scenario: Alta de Instructor con mini Bio
		Given Im a logged in user
		When I create a valid trainer named "Carlos Peix2" and with bio "Gran instructor!"
		And I view the trainer "Carlos Peix2"
		Then I should see "Gran instructor!"

	Scenario: Instructor as English mini Bio
		Given Im a logged in user
		When I create a valid trainer named "Carlos Saul Peix" and with EN bio "Eats too much chicken with hormones!"
		And I view the trainer "Carlos Saul Peix"
		Then I should see "chicken with hormones"
