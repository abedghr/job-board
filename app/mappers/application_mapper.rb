class ApplicationMapper
  def self.map(data)
    if data.is_a?(Array)
      mapAll(data)
    else
      mapOne(data)
    end
  end

  def self.mapOne(application)
    {
      id: application['id'],
      reusme: application['resume'],
      created_at: application['created_at'],
      user: application['user'],
      post: application['post'],
    }
  end

  def self.mapAll(applications)
    applications.map { |application| mapOne(application) }
  end
end