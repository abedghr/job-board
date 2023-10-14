class PostsService
  def initialize(post_repository)
    @post_repository = post_repository
  end

  def findOneBy(filter)
    return @post_repository.findOneBy(filter)
  end
  
  def findAll(page, limit, joins = true)
    return @post_repository.findAll(page, limit, joins = true)
  end

  def findActive(page, limit)
    return @post_repository.findActive(page, limit)
  end
  
  def create(current_user, params)
    return @post_repository.create(current_user, params)
  end
  
  def update(post, params)
    return @post_repository.update(post, params)
  end
  
  def delete(post)
    return @post_repository.delete(post)
  end
end