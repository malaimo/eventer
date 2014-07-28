

Given(/^there is one event$/) do
    step 'Im a logged in user'
    step 'I create a valid event of type "Tipo de Evento de Prueba"'
end

When(/^I visit the "(.*?)" registration page$/) do |lang|
  visit '/events/1/participants/new?lang='+lang
end

When(/^I visit the registration page without languaje$/) do
  visit '/events/1/participants/new'
end
