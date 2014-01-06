class Ability
  include CanCan::Ability
  include Repertoire::Groups::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:super_admin)
      can :manage, :all
    else
      can :read, :all
    end
  end
end
