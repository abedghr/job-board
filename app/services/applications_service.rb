class ApplicationsService
  def initialize(applications_repository)
    @applications_repository = applications_repository
  end

  def findOneBy(filter, joins = true)
    result = @applications_repository.findOneBy(filter, joins)
    if joins && result
      result = result.with_joins_json
    end
    return result
  end

  def findByUser(current_user, page, limit, joins = true)
    return @applications_repository.findByUser(current_user, page, limit)
  end
  
  def findAll(page, limit, joins = true)
    return @applications_repository.findAll(page, limit, joins)
  end
    
  def create(current_user, params)
    return @applications_repository.create(current_user, params)
  end

  def update(post, params)
    return @applications_repository.update(post, params)
  end

  def findOneByAdmin(filter, joins = true)
    result = @applications_repository.findOneBy(filter, joins)

    if result && result.status != ApplicationStatusEnums::SEEN
      update(result, {status: ApplicationStatusEnums::SEEN, seen_at: DateTime.now})
    end

    if joins && result
      result = result.with_joins_json
    end

    return result
  end
end