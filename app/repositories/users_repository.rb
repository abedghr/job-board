class UsersRepository

  def findOneBy(filter, with_selector = true)
    Rails.logger.debug("with_selectorwith_selectorwith_selector: #{with_selector}")

    if with_selector
      return User.default_selector.find_by(filter)
    else
      return User.find_by(filter)
    end
  end
  
  def create(params)
    user = User.new(params)
    user.registration = true
    user.role = UserRolesEnums::JOB_SEEKER
    user.save
    return user
  end
end