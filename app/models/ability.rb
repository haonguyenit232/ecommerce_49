class Ability
  include CanCan::Ability

  def initialize user
    can :read, [Product, Category]
    if user.present?
      can :create, [Comment, Rating, Order]
      can [:update, :destroy], [Comment]
      can :read, :all
      if  user.admin?
        can :manage, :all
      end
    end
  end
end
