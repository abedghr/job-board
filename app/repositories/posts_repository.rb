class PostsRepository
  def findOneBy(filter)
    return Post.default_selector.find_by(filter)
  end
  
  def findAll(page, limit, filters = {}, joins = true)
    query = Post.default_selector
    
    query = apply_filters(query, filters) if !filters.empty?

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
    return Post.default_selector.where(is_active: true).order(created_at: :desc).paginate(page: page, per_page: limit)
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

  private
  def apply_filters(query, filters)
    filters.each do |key, value|
      next if value.blank?
      next unless Post.column_names.include?(key.to_s)
      query = query.where(key => value)
    end
  
    query
  end
end