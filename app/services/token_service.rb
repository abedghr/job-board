require 'securerandom'
class TokenService
  def initialize(users_repository)
    @users_repository = users_repository
  end

  def findOneBy(filter, with_selector = true)
    return @users_repository.findOneBy(filter, with_selector)
  end
  
  def login(filter, params)
    user = findOneBy(filter)

    if user
      if user.authenticate(params[:password])
        refresh_token = generate_refresh_token(user)
        token = encode_token(user.id)
        return {error: false, errors_full_messages: nil, user: user, token: token, refresh_token: refresh_token}
      end
      return {error: true, errors_full_messages: user.errors.full_messages , user: nil, token: nil, refresh_token: nil}
    end
    return {error: true, errors_full_messages: "Invalid email or password" , user: nil, token: nil, refresh_token: nil}
  end
  
  def refreshToken(refresh_token_param)
    user = findOneBy({refresh_token: refresh_token_param}, false)
    if user
      if Time.now > user.refresh_token_expiry
        return {error: true, errors_full_messages: "Refresh token has expired" , user: nil, token: nil, refresh_token: nil}
      end
  
      refresh_token = generate_refresh_token(user)
      token = encode_token(user.id)
      return {error: false, errors_full_messages: nil, user: user, token: token, refresh_token: refresh_token}
    else
      return {error: true, errors_full_messages: "Invalid refresh token" , user: nil, token: nil, refresh_token: nil}
    end
  end

  def register(params)
    user = @users_repository.create(params)
    if user.errors.empty?
      refresh_token = generate_refresh_token(user)
      token = encode_token(user.id)
      return {error: false, errors_full_messages: nil, user: user, token: token, refresh_token: refresh_token}
    end
    return {error: true, errors_full_messages: user.errors.full_messages , user: nil, token: nil}
  end

  private

  def encode_token(user_id)
    expiration_time = Time.now.to_i + Rails.application.config_for(:params)['access_token_expiry_time'].to_i
    payload = { 
      user_id: user_id,
      exp: expiration_time
    }
    secret_key = Rails.application.config_for(:params)['jwt_secret_key']
    JWT.encode(payload, secret_key, 'HS256')
  end
  
  def generate_refresh_token(user)
    refresh_token = SecureRandom.hex(32)
    refresh_token_expiry = Rails.application.config_for(:params)['refresh_token_expiry'].to_i.seconds.from_now

    # user.update(refresh_token: refresh_token, refresh_token_expiry: refresh_token_expiry)
    if user.update_columns(refresh_token: refresh_token, refresh_token_expiry: refresh_token_expiry)
      # Update successful
    else
      # Handle validation errors
      Rails.logger.debug("user.errors.full_messages: #{user.errors.full_messages}")
    end
    Rails.logger.debug("Generated Refresh Token: #{user.refresh_token}")
    return refresh_token
  end
end