class AuthBaseController < BaseController
  before_action :current_user
  before_action :load_ability

  private

  def current_user
    token = request.headers['Authorization'].to_s.split(' ').last
    decoded = decode_token(token)
    if decoded
      @current_user = User.find(decoded['user_id'])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def decode_token(token)
    secret_key = @config_param['jwt_secret_key']
    begin
      JWT.decode(token, secret_key, true, algorithm: 'HS256')[0]
    rescue JWT::DecodeError
      nil
    end
  end

  def load_ability
    @current_ability = Ability.new(current_user, controller_name)
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access denied' }, status: :forbidden
  end

end
