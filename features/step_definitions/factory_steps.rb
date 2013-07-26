# encoding: utf-8

Given /^theres an event$/ do
  event_type = FactoryGirl.create(:event_type)
  event = FactoryGirl.create(:event)
  event.event_type = event_type
  event.save!
end

Given /^theres (\d+) event (\d+) week away from now$/ do |amount, weeks_away|
  amount.to_i.times {
    event_type = FactoryGirl.create(:event_type)
    event = FactoryGirl.create(:event)
    event.event_type = event_type
    event.cancelled = false
    event.date = Date.today + 7*weeks_away.to_i 
    event.save!
  }
end

Given /^theres an influence zone$/ do
  country = FactoryGirl.create(:country)
  zi = FactoryGirl.create(:influence_zone)
  zi.country = country
  zi.zone_name = "Buenos Aires"
  zi.save!
end