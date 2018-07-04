class Ability
  include CanCan::Ability

  def initialize user
    can :read, [Product, Category]
    if user.present?
      can :create, [Comment, Rating]
      can :update, Rating
      can :read, :all
      if  user.admin?
        can :manage, :all
      end
    end
  end
end
