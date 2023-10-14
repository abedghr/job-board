class UserMapper
  def self.map(data)
    if data.is_a?(Array)
      mapAll(data)
    else
      mapOne(data)
    end
  end

  def self.mapOne(user)
    {
      id: user['id'],
      email: user['email'],
      role: user['role'],
      created_at: user['created_at'],
    }
  end

  def self.mapAll(users)
    users.map { |user| mapOne(user) }
  end
end