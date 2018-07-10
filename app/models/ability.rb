class Ability
  include CanCan::Ability

  def initialize user
    can :read, :all
    if user.present?
      can :create, [Comment, Rating, Order]
      can [:update, :destroy], Comment, user_id: user.id
      can :cancel, Order, user_id: user.id
      can :read, :all
      if  user.admin?
        can :manage, :all
      end
    end
  end
end
