class PostMapper
  def self.map(data)
    if data.is_a?(Array)
      mapAll(data)
    else
      mapOne(data)
    end
  end

  def self.mapOne(post)
    {
      id: post['id'],
      title: post['title'],
      description: post['description'],
      is_active: post['is_active'],
      created_at: post['created_at'],
      user: post['user'],
    }
  end

  def self.mapAll(posts)
    posts.map { |post| mapOne(post) }
  end
end