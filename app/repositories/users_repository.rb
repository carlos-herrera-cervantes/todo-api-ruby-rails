class UsersRepository

  def get_all (query_parameters)
    relation = query_parameters.key?('with') ? query_parameters['with'] : false

    if relation
      return User.collection.aggregate([
        {
          '$lookup' => {
            from: relation,
            localField: '_id',
            foreignField: 'user_id',
            as: 'todos',
          }
        }
      ])
    end
    
    User.all 
  end

  def get_by_id (id)
    User.find(id)
  end

end