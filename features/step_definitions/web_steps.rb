# encoding: utf-8

def create_valid_event(event_type_name)
  create_valid_event_inputs event_type_name
end

def create_valid_event_inputs(event_type_name, event_date='31-01-2030')
  select event_type_name, :from => 'event_event_type_id'
  fill_in 'event_date', :with => event_date
  fill_in 'event_duration', :with => 2
  fill_in 'event_date', :with => event_date
  fill_in 'event_place', :with => 'Hotel Llao Llao'
  fill_in 'event_capacity', :with => 25
  fill_in 'event_city', :with => 'Buenos Aires'
  select 'Argentina', :from => 'event_country_id'
  select 'John Doe', :from => 'event_trainer_id'
  choose 'event_visibility_type_pu'
  fill_in 'event_list_price', :with => 500.00
  check 'event_list_price_plus_tax'
  fill_in 'event_list_price_2_pax_discount', :with =>  10
  fill_in 'event_list_price_3plus_pax_discount', :with =>  15
  fill_in 'event_eb_price', :with => 450.00
  fill_in 'event_eb_end_date', :with => '21-01-2030'
end

def submit_event
  click_button 'Ok'
end

Given /^I visit the home page$/ do
  visit "/"
end

Given /^I visit the events page$/ do
  visit "/events"
end

Given /^Im a logged in user$/ do
  visit "/users/sign_in"
  fill_in 'user_email', :with => 'ejemplo@eventer.heroku.com'
  fill_in 'user_password', :with => 'secret1'
  click_button 'Sign in'
end


Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

When /^I create a valid event of type "([^\"]*)"$/ do |event_name|
  visit "/events/new"
  create_valid_event event_name
  submit_event
end

When /^I create an invalid event with "([^"]*)" as "([^"]*)"$/ do |value, attribute|
  visit "/events/new"
  create_valid_event 'Tipo de Evento de Prueba'
  fill_in attribute, :with => value
  submit_event
end

When /^I create a public event on "([^\"]*)"$/ do |value|
  visit "/events/new"
  create_valid_event_inputs 'Tipo de Evento de Prueba', value
  fill_in 'event_date', :with => value
  fill_in 'event_capacity', :with => '10' # solo para sacar el foco del event_date
end

When /^I create an private event with discounts$/ do
  visit "/events/new"
  create_valid_event 'Tipo de Evento de Prueba'
  choose 'event_visibility_type_pr'
  fill_in 'event_list_price_2_pax_discount', :with =>  10
  fill_in 'event_list_price_3plus_pax_discount', :with =>  15  
  submit_event
end

When /^I create an empty event$/ do
  visit "/events/new"
  submit_event
  sleep 10
end

When /^I visit the event listing page$/ do
  visit "/events"
end

Then /^I should be on the events listing page$/ do
  current_path.should == events_path
end


Then /^I should see one event$/ do
  page.should have_content('Curso de Meteorología Básica I')
end

When /^I choose to create a Private event$/ do
  visit "/events/new"
  create_valid_event_inputs 'Tipo de Evento de Prueba'
  choose 'event_visibility_type_pr'
end

When /^I choose to create a Community event$/ do
  visit "/events/new"
  create_valid_event_inputs 'Tipo de Evento de Prueba'
  choose 'event_visibility_type_co'
end

When /^I choose to create a Public event$/ do
  visit "/events/new"
  create_valid_event_inputs 'Tipo de Evento de Prueba'
  choose 'event_visibility_type_pu'
end

Then /^I should not see public prices$/ do
  page.find_field('event_eb_price').visible?.should be false
end

Then /^I should not see any price$/ do
  page.find_field('event_eb_price').visible?.should be false
  page.find_field('event_list_price').visible?.should be false
  page.find_field('event_eb_end_date').visible?.should be false
end

Then /^I should see public prices$/ do
  page.find_field('event_eb_price').visible?.should be true
end

When /^I choose to create a Webinar event$/ do
  visit "/events/new"
  create_valid_event_inputs 'Tipo de Evento de Prueba'
  check 'event_is_webinar'
end

Then /^I should see the webinar setup$/ do
  page.find_field('event_city').value.should == "Webinar"
  page.find_field('event_country_id').value.should == "245" # "-- OnLine --"
end

Then /^EB date should be "([^\"]*)"$/ do |value|
  page.find_field('event_eb_end_date').value.should == value
end

When /^I modify the event "([^\"]*)"$/ do |link_description|
  click_link link_description
  click_link "Modificar"
  sleep 10
  fill_in 'event_capacity', :with => 200
  click_button "Guardar Cambios"
  sleep 10
end

When /^I cancel the event "([^\"]*)"$/ do |link_description|
  click_link link_description
  click_link "Modificar"
  sleep 10
  check 'event_cancelled'
  click_button "Guardar Cambios"
  sleep 10
end

Then /^I should not see "([^\"]*)"$/ do |text|
  page.should_not have_content( text )
end

When /^I register for that event$/ do
  @event = Event.first
  visit '/events/'+@event.id.to_s+'/participants/new'
  fill_in 'participant_fname', :with => 'Juan'
  fill_in 'participant_lname', :with => 'Callidoro'
  fill_in 'participant_email', :with => 'jcallidoro@gmail.com'
  fill_in 'participant_phone', :with => '1234-5678'
  click_button 'Registrarme'
end

Then /^I should see a confirmation message$/ do
  current_path.should == '/registration_confirmed'
  page.should have_content('Tu registro fue realizado exitosamente.')
end

Then /^It should have a registration page$/ do
  @event = Event.first
  visit '/events/'+@event.id.to_s+'/participants/new'
  
  page.should have_content(@event.event_type.name )
  page.should have_content(@event.date.to_formatted_s(:short) )
  page.should have_content(@event.city )
  
  page.should have_content('Nombre')
  page.should have_content('Apellido')
  page.should have_content('E-Mail')
  page.should have_content('Teléfono de contacto')
end

When /^I visit the dashboard$/ do
  visit '/dashboard'
  sleep 10
end

def create_new_participant
  visit "/events/1/participants/new"
  fill_in 'participant_fname', :with => 'Juan'
  fill_in 'participant_lname', :with => 'Callidoro'
  fill_in 'participant_email', :with => 'jcallidoro@gmail.com'
  fill_in 'participant_phone', :with => '1234-5678'
  click_button 'Registrarme'
end

def contact_participant
  visit "/events/1/participants"
  click_link "Modificar"
  select "Contactado", :from => 'participant_status'
  click_button 'Modificar'
end

Given /^there are (\d+) participants and 1 is contacted$/ do |newones|
  newones.to_i.times { 
    create_new_participant
  }
   
  contact_participant
  
end



