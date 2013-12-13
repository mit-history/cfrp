class Ability
  include CanCan::Ability
  include Repertoire::Groups::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    defaults_for user

    # can :manage, Post
    # can :read, User
    # can :manage, User, :id => user.id
    # can :read, ActiveAdmin::Page, :name => "Dashboard"

    if user.has_role? :admin
      can :destroy, Register
      can :manage, :all

    elsif user.has_role? :editor
      cannot :destroy, Register
      can [:create, :read, :update], Register

    elsif user.has_role? :verifier
      cannot :manage, :all
      can [:read, :update], Register

    else
      cannot :manage, :all
      can :read, Register
    end
  end
end
