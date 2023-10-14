class PostsService
  def initialize(post_repository)
    @post_repository = post_repository
  end

  def findOneBy(filter)
    return @post_repository.findOneBy(filter)
  end
  
  def findAll(page, limit, filters = {}, joins = true)
    return @post_repository.findAll(page, limit, filters, joins = true)
  end

  def findActive(page, limit)
    return findAll(page, limit, {is_active: true})
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