class Api::AdminApplicationsController < AuthBaseController
  load_and_authorize_resource class: 'Application'
  before_action :get_applications_service

  def index
    page = getPageParam()
    limit = getLimitParam()

    result = @applications_service.findAll(page, limit)
    
    next_page = result[:next_page]
    offset = getOffset(next_page, limit)

    # The API URL for the next page
    next_page_url = next_page ? api_applications_url(page: next_page, limit: limit) : nil

    response_data = {
      data: result[:data],
      next: next_page_url.present? ? { url: next_page_url, offset: offset } : nil
    }

    render json: response_data, status: :ok
  end
  
  def show
    result = @applications_service.findOneByAdmin({id: params[:id]})
    if result
      render json: result, status: :ok
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  private

  def get_applications_service
    @applications_service = DependencyContainer[:applications_service]
  end
end
