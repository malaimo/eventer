class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new

    if user.role? :administrator
      can :manage, [Role, User, Event, Trainer]
    elsif user.role? :comercial
      can :manage, [Event, Trainer]
    end
  end
end