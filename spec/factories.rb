# encoding: utf-8
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
  
  factory :country do
    name "Argentina"
    iso_code "AR"
  end
  
  factory :trainer do
    name "Juan Alberto"
  end
 
  factory :event_type do
     name "Tipo de Evento de Prueba"
     goal "Un objetivo"
     description "Una descripción"
     recipients "algunos destinatarios"
     program "El programa del evento"
   end
  
  factory :event do
    event_type Factory.build(:event_type)
    date "23/01/2100"
    place "Hotel Conrad"
    city "Punta del Este"
    capacity 20
    visibility_type 'pu'
    list_price 500.00
    country Factory.build(:country)
    trainer Factory.build(:trainer)
  end

end
