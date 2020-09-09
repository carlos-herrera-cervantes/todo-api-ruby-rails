class TodosManager

  def create(todo)
    created = Todo.new(todo)

    if created.save
      created
    end
  end

  def update(id, todo)
    finded = Todo.find(id)
    
    if finded.update(todo)
      finded
    end
  end

  def delete(id)
    todo = Todo.find(id)
    todo.destroy
  end

end