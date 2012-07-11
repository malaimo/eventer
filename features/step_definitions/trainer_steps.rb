# encoding: utf-8

When /^I create a valid trainer named "([^"]*)"$/ do |name|
	visit '/trainers/new'
	fill_in 'trainer_name', :with => name
	click_button 'Ok'
end

When /^I create a valid trainer named "([^"]*)" and with bio "([^"]*)"$/ do |name, bio|
	visit '/trainers/new'
	fill_in 'trainer_name', :with => name
	fill_in 'trainer_bio', :with => bio
	click_button 'Ok'
end

Then /^I should be on the trainers listing page$/ do
  current_path.should == trainers_path
end

When /^I view the trainer "([^"]*)"$/ do |trainer_name|
	click_link trainer_name
end
