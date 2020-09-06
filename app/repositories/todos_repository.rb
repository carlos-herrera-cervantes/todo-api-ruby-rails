class TodosRepository

  def get_all
    Todo.all 
  end

  def get_by_id (id)
    Todo.find(id)
  end

end