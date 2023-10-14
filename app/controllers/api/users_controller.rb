class Api::UsersController < AuthBaseController
  def index
    render json: UserMapper.map(current_user), status: :ok
  end
end
