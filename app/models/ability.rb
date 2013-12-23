class Ability
  include CanCan::Ability
  include Repertoire::Groups::Ability

  def initialize(user)
    defaults_for user
  end
end
