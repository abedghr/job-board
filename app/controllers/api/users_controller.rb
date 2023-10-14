class Api::UsersController < AuthBaseController
  def index
    response_data = {
      email: @current_user.email,
      created_at: @current_user.created_at,
      updated_at: @current_user.updated_at
    }

    render json: response_data, status: :ok
  end
end
