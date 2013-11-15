class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.role.admin?
    can :read, [Post, Category] if user.role.user?
  end
end
