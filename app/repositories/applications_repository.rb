class ApplicationsRepository
  def findOneBy(filter, joins = true)
    query = Application

    if joins
      query = query.with_joins
    end

    result = query.find_by(filter)
    return result
  end

  def findByUser(current_user, page, limit, joins = true)
    # result = current_user.applications.order(seen_at: :desc, created_at: :desc).paginate(page: page, per_page: limit)
    query = current_user.applications
    if joins
      query.includes(:user, :post)
    end

    result = query.order(seen_at: :desc, created_at: :desc).paginate(page: page, per_page: limit)
    
    data = []
    if !result.empty?
      data = result.map(&:with_joins_json)
    end

    return {
      data: data,
      next_page: result.next_page
    }
  end
  
  def findAll(page, limit, joins = true)
    query = Application
    
    if joins
      query.includes(:user, :post)
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

  def create(current_user, params)
    application = current_user.applications.build(params)
    application.save
    return application
  end

  def update(application, params, joins = true)
    application.update(params)
    return application
  end
end