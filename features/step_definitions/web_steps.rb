# encoding: utf-8

def create_valid_event(event_name)
  create_valid_event_inputs event_name
  create_valid_event_texts
end

def create_valid_event_inputs(event_name, event_date='31-01-2030')
  fill_in 'event_name', :with => event_name
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
  fill_in 'event_seb_price', :with => 400.00
  fill_in 'event_seb_end_date', :with => '31-12-2029'
  fill_in 'event_eb_price', :with => 450.00
  fill_in 'event_eb_end_date', :with => '21-01-2030'
end

def create_valid_event_texts
  fill_in 'event_description', :with => 'Este es un curso de prueba...'
  fill_in 'event_recipients', :with => 'Pilotos, Despachantes de Vuelo, Azafatas'
  fill_in 'event_program', :with => 'Nubes, Estratos, Corrientes, Windshields'
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


Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

When /^I create a valid event named "([^"]*)"$/ do |event_name|
  visit "/events/new"
  create_valid_event event_name
  submit_event
end

When /^I create an invalid event with "([^"]*)" as "([^"]*)"$/ do |value, attribute|
  visit "/events/new"
  create_valid_event 'Evento de Ejemplo'
  fill_in attribute, :with => value
  submit_event
end

When /^I create a public event on "([^"]*)"$/ do |value|
  visit "/events/new"
  create_valid_event_inputs 'Evento de Ejemplo', value
  fill_in 'event_date', :with => value
  fill_in 'event_name', :with => 'solo para sacar el foco del event_date y asi lanzar el evento change...'
end

When /^I create an private event with discounts$/ do
  visit "/events/new"
  create_valid_event 'Evento de Ejemplo'
  choose 'event_visibility_type_pr'
  fill_in 'event_list_price_2_pax_discount', :with =>  10
  fill_in 'event_list_price_3plus_pax_discount', :with =>  15  
  submit_event
end

When /^I create an empty event$/ do
  visit "/events/new"
  submit_event
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
  create_valid_event_inputs 'Evento de Ejemplo'
  choose 'event_visibility_type_pr'
end

When /^I choose to create a Public event$/ do
  visit "/events/new"
  create_valid_event_inputs 'Evento de Ejemplo'
  choose 'event_visibility_type_pu'
end

Then /^I should not see public prices$/ do
  page.find_field('event_seb_price').visible?.should be false
  page.find_field('event_eb_price').visible?.should be false
end

Then /^I should see public prices$/ do
  page.find_field('event_seb_price').visible?.should be true
  page.find_field('event_eb_price').visible?.should be true
end

Then /^EB date should be "([^"]*)"$/ do |value|
  page.find_field('event_eb_end_date').value.should == value
end

Then /^SEB date should be "([^"]*)"$/ do |value|
  page.find_field('event_seb_end_date').value.should == value
end


