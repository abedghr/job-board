class UsersRepository

  def findOneBy(filter)
    return User.find_by(filter)
  end
  
  def create(params)
    user = User.new(params)
    user.registration = true
    user.role = UserRolesEnums::JOB_SEEKER
    user.save
    return user
  end
end