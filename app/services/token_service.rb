class TokenService
  def initialize(users_repository)
    @users_repository = users_repository
  end

  def findOneBy(filter)
    return @users_repository.findOneBy(filter)
  end
  
  def login(filter, params)
    user = findOneBy(filter)

    if user && user.authenticate(params[:password])
      token = encode_token(user.id)
      return {error: false, errors_full_messages: nil, user: user, token: token}
    end
      return {error: true, errors_full_messages: user.errors.full_messages , user: nil, token: nil}
  end

  def register(params)
    user = @users_repository.create(params)
    if user.errors.empty?
      token = encode_token(user.id)
      return {error: false, errors_full_messages: nil, user: user, token: token}
    end
    return {error: true, errors_full_messages: user.errors.full_messages , user: nil, token: nil}
  end

  private

  def encode_token(user_id)
    payload = { user_id: user_id }
    secret_key = Rails.application.config_for(:params)['jwt_secret_key']
    JWT.encode(payload, secret_key, 'HS256')
  end
end