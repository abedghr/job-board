class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [
    :login_user, 'users#login_user',
    :register_user, 'users#register_user'
  ]

  private

  def authenticate_user
    token = request.headers['Authorization'].to_s.split(' ').last
    decoded = decode_token(token)
    if decoded
      @current_user = User.find(decoded['user_id'])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def decode_token(token)
    secret_key = "b8bd58d7f46c0dc5ab46b90fc75eb23f8dd7c032c51c98c163a0c234f8a253b397248cb754b92e0a1a75cc3d644a5500a8734b753cc93436ab4a00fa0b56951c"
    begin
      JWT.decode(token, secret_key, true, algorithm: 'HS256')[0]
    rescue JWT::DecodeError
      nil
    end
  end
end
