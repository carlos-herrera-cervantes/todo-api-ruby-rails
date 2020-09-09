require_relative '../modules/mongodb_module.rb'

class UsersRepository

  def get_all(query_parameters)
    relation = query_parameters.key?('with') ? query_parameters['with'] : false
    
    if relation
      filter = MongodbModule.build_filter(query_parameters, 'user')
      return User.collection.aggregate(filter)
    end
    
    User.all 
  end

  def get_by_id(id)
    User.find(id)
  end

  def get_one(filter)
    User.find_by(filter)
  end

end