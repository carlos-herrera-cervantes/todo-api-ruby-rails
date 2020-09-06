class UsersManager

  def create (user)
    created = User.new(user)

    if created.save
      created
    end
  end

  def update (id, user)
    finded = User.find(id)
    
    if finded.update(user)
      finded
    end
  end

  def delete (id)
    user = User.find(id)
    user.destroy
  end

end