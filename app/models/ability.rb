class Ability
  include CanCan::Ability

  def initialize(user)
    send("#{user.role}_permission", user)
  end

  def superadmin_permission(user)
    can :manage, :all
  end

  def client_permission(user)
    can :manage, Todo, { user_id: user.id }
    can [:read, :update], User, { id: user.id }
  end

end