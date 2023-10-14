class BaseController < ActionController::API
  before_action :load_config_param
  def getPageParam()
    page = (params[:page] || @config_param['default_page_param'] || 1).to_i
    if page < 1
      raise ArgumentError, 'page param must be greater than or equal to 1'
    end

    return page
  end
  
  def getLimitParam()
    limit = (params[:limit] || @config_param['default_limit_param'] || 2).to_i
    if limit < 1
      raise ArgumentError, 'limit param must be greater than or equal to 1'
    end

    if limit > @config_param['max_limit_param_value']
      raise ArgumentError, "limit param must be less than or equal to #{@config_param['max_limit_param_value']}"
    end

    return limit
  end
  
  def getOffset(next_page = nil, limit)
    return next_page ? (next_page - 1) * limit : nil
  end

  private

  def load_config_param
    @config_param = Rails.application.config_for(:params)
  end
end
