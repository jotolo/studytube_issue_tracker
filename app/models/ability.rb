class Ability
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user (not logged in)
       if user.is_manager?
         # be able to see the list of all issues
         can :index, Issue
         # be able to assign an issue to only yourself and only if it is not already assigned to somebody else
         # be able to unassign an issue from yourself
         can :update, Issue, manager_id: [user.id, nil]
         can :show, Issue
       elsif user.is_user?
         # see the list of only your issues (most recent at the top)
         can :index, Issue
         # be able to create/update/delete only your issues
         can :create, Issue, user_id: user.id
         can :update, Issue, user_id: user.id
         can :destroy, Issue, user_id: user.id
         # see only your issues
         can :show, Issue, user_id: user.id

       end
  end
end
