# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creación del primer usuario. es necesario cambiar el password tan pronto como se haga el rake db:seed
@admin_role = Role.create( :name => :administrator )

Role.create( 
  :name => :comercial
)

User.create do |u|
  u.email = "ejemplo@eventer.heroku.com"
  u.password = "secret1"
  u.password_confirmation = "secret1"
  u.roles << @admin_role
end

@trainers = Trainer.create([
  {:name => 'John Doe'},
  {:name => 'Jeff Baurer'},
  {:name => 'Michael Donovan'}
])

EventType.create([
  {
    :name => 'Tipo de Evento de Prueba', 
    :duration => 8,
    :goal => 'Un objetivo', 
    :description => 'Una descripción', 
    :recipients => 'Un destinatario', 
    :program => 'El programa',
    :elevator_pitch => 'Este es el mejor tipo de evento',
    :trainers => @trainers},
])