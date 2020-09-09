class TodosRepository

  def get_all(query_parameters)
    relation = query_parameters.key?('with') ? query_parameters['with'] : false
    
    if relation
      filter = MongodbModule.build_filter(query_parameters, 'todo')
      return Todo.collection.aggregate(filter)
    end

    Todo.all 
  end

  def get_by_id(id)
    Todo.find(id)
  end

end