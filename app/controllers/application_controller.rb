class ApplicationController < ActionController::API
  before_action :set_locale

  attr_reader :user_repository

  rescue_from CanCan::AccessDenied do |exception|
    render json: { status: false, code: 'AccessDenied', message: I18n.t(:Unauthorized) }, status: :unauthorized
  end

  def initialize(user_repository = UsersRepository.new)
    @user_repository = user_repository
  end

  protected

  def set_locale
    I18n.locale = request.headers['Accept-Language'] || 'en'
  end

  def authorize_request
    token = get_token
    begin
      JsonWebToken.decode(token)
    rescue Mongoid::Errors::DocumentNotFound => error
      render json: { status: true, code: 'Unauthorized', message: I18n.t(:UserNotFound) }, status: :unauthorized
    rescue JWT::DecodeError => error
      render json: { status: true, code: 'Unauthorized', message: I18n.t(:InvalidToken) }, status: :unauthorized
    end
  end

  def current_user
    begin
      token = get_token
      decoded = JsonWebToken.decode(token)
      @user = user_repository.get_by_id(decoded[:user_id])
    rescue  => exception
      render json: { status: true, code: 'Unauthorized', message: I18n.t(:InvalidToken) }, status: :unauthorized
    end
  end

  private

  def get_token
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    token
  end

end
