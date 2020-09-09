require_relative '../modules/users_module.rb'

class AuthenticationController < ApplicationController
  attr_reader :user_repository

  def initialize(user_repository = UsersRepository.new)
    @user_repository = user_repository
  end

  def login
    begin
      user = user_repository.get_one('email' => params[:email])
      
      if user.password == (params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        time = Time.now + 24.hours.to_i
        render json: { status: true, data: token }
      else
        render json: { status: false, code: 'Unauthorized', message: I18n.t(:InvalidCredentials) }
      end
    rescue => exception
      error = UsersModule.get_parse_error(exception)
      render json: { status: false, code: error['code'], message: error['message'] }, status: error['status_code']
    end
  end

end