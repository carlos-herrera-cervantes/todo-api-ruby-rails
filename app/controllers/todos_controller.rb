class TodosController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_todo, only: [:show, :update, :destroy]
  before_action :set_user, only: [:create_by_user]

  load_and_authorize_resource except: :create

  attr_reader :todo_repository
  attr_reader :todo_manager
  attr_reader :user_repository

  def initialize(todo_repository = TodosRepository.new, todo_manager = TodosManager.new, user_repository = UsersRepository.new)
    @todo_repository = todo_repository
    @todo_manager = todo_manager
    @user_repository = user_repository
  end

  def index
    todos = todo_repository.get_all(request.query_parameters)
    render json: { status: true, data: todos }
  end

  def show
    render json: { status: true, data: @todo }
  end

  def create
    todo = todo_manager.create(todo_params)
    render json: { status: true, data: todo }, status: :created
  end

  def create_by_user
    merge = {}.merge(todo_params, { 'user_id' => params[:id] })
    todo = todo_manager.create(merge)
    render json: { status: true, data: todo }, status: :created
  end

  def update
    todo = todo_manager.update(params[:id], todo_params)
    render json: { status: true, data: todo }, status: :created
  end

  def destroy
    todo_manager.delete(params[:id])
  end

  private

  def set_todo
    begin
      @todo = todo_repository.get_by_id(params[:id])
    rescue => exception
      error = TodosModule.get_parse_error(exception)
      render json: { status: false, code: error['code'], message: error['message'] }, status: error['status_code']
    end
  end

  def set_user
    begin
      user_repository.get_by_id(params[:id])
    rescue => exception
      error = UsersModule.get_parse_error(exception)
      render json: { status: false, code: error['code'], message: error['message'] }, status: error['status_code']
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :done, :user_id)
  end

end