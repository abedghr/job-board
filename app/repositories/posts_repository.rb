class PostsRepository
  def findOneBy(filter)
    return Post.find_by(filter)
  end
  
  def findAll(page, limit, joins = true)
    query = Post
    
    if joins
      query.includes(:user)
    end

    result = query.order(created_at: :desc).paginate(page: page, per_page: limit)
    
    data = []
    if !result.empty?
      data = result.map(&:with_joins_json)
    end

    return {
      data: data,
      next_page: result.next_page
    }

  end

  def findActive(page, limit)
    return Post.where(is_active: true).order(created_at: :desc).paginate(page: page, per_page: limit)
  end
  
  def create(current_user, params)
    post = current_user.posts.build(params)
    post.save
    return post
  end

  def update(post, params)
    post.update(params)
    return post
  end
  
  def delete(post)
    post.destroy
    return post
  end
end