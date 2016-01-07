class Panda

  attr_accessor :name, :email, :gender

  def initialize(name, email, gender)
    @name, @email, @gender = name, email, gender
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

  end

  def equal?(other)
    name == other.name && email == other.email && gender == other.gender
  end
end

class PandaSocialNetwork
 
 

end
