class Panda

  attr_accessor :name, :email, :gender, :friends

  def initialize(name, email, gender)
    @name, @email, @gender = name, email, gender
    @friends = []
  end

  def male?
    gender == "male"
  end

  def female?
    gender == "female"
  end

  def to_s
    "Name: #{name}, email: #{email}, gender: #{gender}"
  end

  def to_hash
    #h[panda] = 
  end

  def equal?(other)
    name == other.name && email == other.email && gender == other.gender
  end
end

class PandaSocialNetwork

  def initialize
    @network = []
  end

  def make_friends(panda1, panda2)
    raise "PandasAlreadyFriends" if are_friends(panda1, panda2)

    add_panda(panda1) unless has_panda(panda1)
    add_panda(panda2) unless has_panda(panda2)

    panda1.friends << panda2
    panda2.friends << panda1
  end
  
  def friends_of(panda)
    panda.friends
  end

  def are_connected(panda1, panda2)
  end

end