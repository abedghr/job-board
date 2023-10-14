class Api::ApplicationsController < AuthBaseController
  load_and_authorize_resource
  before_action :get_applications_service

  def index
    page = getPageParam()
    limit = getLimitParam()

    result = @applications_service.findByUser(@current_user, page, limit)

    next_page = result[:next_page]
    offset = getOffset(next_page, limit)

    # The API URL for the next page
    next_page_url = next_page ? api_applications_url(page: next_page, limit: limit) : nil

    response_data = {
      data: ApplicationMapper.map(result[:data]),
      next: next_page_url.present? ? { url: next_page_url, offset: offset } : nil
    }

    render json: response_data, status: :ok
  end

  def create
    result = @applications_service.create(@current_user, application_params)
    if result.errors.empty?
      serialized_result = ApplicationMapper.map(result.with_joins_json)
      render json: serialized_result, status: :created
    else
      render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    result = @applications_service.findOneBy({id: params[:id]})
    if result
      render json: ApplicationMapper.map(result), status: :ok
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  private

  def application_params
    params.permit(:post_id, :resume)
  end

  def get_applications_service
    @applications_service = DependencyContainer[:applications_service]
  end
end
