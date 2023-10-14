class Api::PostsController < AuthBaseController
  load_and_authorize_resource
  before_action :get_posts_service

  def index
    page = getPageParam()
    limit = getLimitParam()
    posts_service = DependencyContainer[:posts_service]

    result = @posts_service.findActive(page, limit)
    
    next_page = result[:next_page]
    offset = getOffset(next_page, limit)

    # The API URL for the next page
    next_page_url = next_page ? api_posts_url(page: next_page, limit: limit) : nil

    response_data = {
      data: PostMapper.map(result[:data]),
      next: next_page_url.present? ? { url: next_page_url, offset: offset } : nil
    }

    render json: response_data, status: :ok
  end
  
  private
  def post_params
    params.permit(:is_active, :title, :description)
  end

  def get_posts_service
    @posts_service = DependencyContainer[:posts_service]
  end

end
