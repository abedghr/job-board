require "./app/enums/user_roles_enums.rb"

class Ability
  include CanCan::Ability

  def initialize(user, current_controller = nil)
    user ||= User.new

    if user.role == UserRolesEnums::ADMIN
      can :create, Post
      can :update, Post, user_id: user.id
      can :destroy, Post, user_id: user.id
      if current_controller && current_controller.start_with?('admin_')
        can :read, Post
        can :read, Application
      end
    else
      if current_controller && !current_controller.start_with?('admin_')
        can :read, Post
        can :read, Application, user_id: user.id
        can :create, Application
      end
    end
  end
end
