class Api::TokenController < PublicBaseController
  before_action :get_token_service

  # TODO:: Add OTP verification + add rate limit into it to avoid many requests by human or automation
  def register
    result = @token_service.register(user_params)
    if !result[:error]
      render json: { auth_token: result[:token], user: UserMapper.map(result[:user]) }, status: :created
    else
      render json: { errors: result[:errors_full_messages] }, status: :unprocessable_entity
    end
  end

  def login
    result = @token_service.login({email: params[:email]}, params)
    if !result[:error]
      render json: { auth_token: result[:token], user: UserMapper.map(result[:user]) }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def get_token_service
    @token_service = DependencyContainer[:token_service]
  end

end
