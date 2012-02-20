class Country < ActiveRecord::Base
  
  def to_s
    iso_code + " - " +name
  end

end
