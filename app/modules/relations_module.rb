module RelationsModule
  extend self

  def get_factory_relation(type)
    case type
    when 'user'
      get_relations_for_users
    when 'todo'
      get_relations_for_todos
    end
  end

  # region Users

  def get_relations_for_users
    {
      'todos' => {
        'localField' => '_id',
        'foreignField' => 'user_id'
      }
    }
  end

  # endregion

  # region Todos

  def get_relations_for_todos
    {
      'users' => {
        'localField' => 'user_id',
        'foreignField' => '_id'
      }
    }
  end

  # endregion

end