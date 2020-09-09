module UsersModule
  extend self

  def get_parse_error(exception)
    case 
    when exception.class == Mongoid::Errors::DocumentNotFound
      { 'code' => 'NotFound', 'message' => I18n.t(:UserNotFound), 'status_code' => :not_found }
    end
  end

end