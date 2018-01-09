class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    # byebug
    # if user.agent?
    #   agent_permissions(user)
    # elsif user.customer?
    #   customer_permissions(user)
    # end
  end

  private

  def agent_permissions(user)
    # can :manage, Team do |team|
    #   team.assigned_agent? user
    # end
    # can :manage, Tour do |tour|
    #   tour.team.assigned_agent? user
    # end

    # can :add_houses, :team do |resource, team|
    #   team.assigned_agent? user
    # end

    # can :archive_houses, :team do |resource, team|
    #   team.assigned_agent? user
    # end

    # can :manage, House
    # can :show, User
  end

  def customer_permissions(user)
    # can :read, Team
    # can :read, Tour
    # can :add_houses, :team do |resource, team|
    #   team.members.include?(user)
    # end
    # can :archive_houses, :team do |resource, team|
    #   team.members.include?(user)
    # end
    # can :manage, House
    # can :show, User
  end
end
