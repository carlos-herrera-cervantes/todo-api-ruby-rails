class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user, only: [:show, :update, :destroy]

  load_and_authorize_resource except: :create

  attr_reader :user_repository
  attr_reader :user_manager

  def initialize(user_repository = UsersRepository.new, user_manager = UsersManager.new)
    @user_repository = user_repository
    @user_manager = user_manager
  end

  def index
    users = user_repository.get_all(request.query_parameters)
    render json: { status: true, data: users }
  end

  def show
    render json: { status: true, data: @user }
  end

  def create
    user = user_manager.create(user_params)
    render json: { status: true, data: user }, status: :created
  end

  def update
    user = user_manager.update(params[:id], user_params)
    render json: { status: true, data: user }, status: :created
  end

  def destroy
    user_manager.delete(params[:id])
  end

  private

  def set_user
    begin
      @user = user_repository.get_by_id(params[:id])
    rescue => exception
      error = UsersModule.get_parse_error(exception)
      render json: { status: false, code: error['code'], message: error['message'] }, status: error['status_code']
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :last_name, :role, :password)
  end

end