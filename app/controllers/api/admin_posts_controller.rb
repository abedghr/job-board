class Api::AdminPostsController < AuthBaseController
  load_and_authorize_resource class: 'Post'
  before_action :get_posts_service
  before_action :find_post_by_id, only: [:update, :destroy]

  def index
    page = getPageParam()
    limit = getLimitParam()

    result = @posts_service.findAll(page, limit)
    
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

  def create
    result = @posts_service.create(@current_user, admin_post_params)

    if result.errors.empty?
      render json: PostMapper.map(result.with_joins_json), status: :created
    else
      render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post
      result = @posts_service.update(@post, admin_post_params)
      if result.errors.empty?
        render json: PostMapper.map(result.with_joins_json), status: :ok
      else
        render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  def destroy
    if @post
      result = @posts_service.delete(@post)
      if result.errors.empty?
        render json: nil, status: :no_content
      else
        render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  
  private
  def admin_post_params
    params.permit(:title, :description)
  end

  def find_post_by_id
    @post = @posts_service.findOneBy({id: params[:id]})
  end

  def get_posts_service
    @posts_service = DependencyContainer[:posts_service]
  end
end
