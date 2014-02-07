class AddShouldWelcomeEmailToEvent < ActiveRecord::Migration
  def change
    add_column :events, :should_welcome_email, :boolean, defauls: true
  end
end
