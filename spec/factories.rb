require 'factory_girl'

FactoryGirl.define do
  
  factory :user do
    email 'user@test.com'
    password 'please'
    password_confirmation 'please'
  end

  factory :admin_role, :class => Role do
    name :administrator
  end

  factory :comercial_role, :class => Role do
    name :comercial
  end

  factory :administrator, :class => User do
    email 'admin@user.com'
    password 'please'
    password_confirmation 'please'
    roles [ Factory.create(:admin_role) ]
  end

  factory :comercial, :class => User do
    email 'comercial@user.com'
    password 'please'
    password_confirmation 'please'
    roles [ Factory.create(:comercial_role) ]
  end

end
