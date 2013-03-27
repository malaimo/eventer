# encoding: utf-8

Given /^theres an event$/ do
  event_type = FactoryGirl.create(:event_type)
  event = FactoryGirl.create(:event)
  event.event_type = event_type
  event.save!
end