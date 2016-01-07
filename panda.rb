class Panda

  attr_accessor :name, :email, :gender

  def initialize(name, email, gender)
    @name = name
    @email = email
    @gender = gender
  end

  def male?
    true if gender == 'male'
  end

  def female?
    true if gender == 'female'
  end

  def to_s
    "Name: #{name}, Email: #{email}, Gender: #{gender}"
  end

  def to_h

  end

  def equal?(other)
    name == other.name and email == other.email and gender == other.gender
  end

end

class PandaSocialNetwork

  attr_accessor :network

  def initialize
    @network = []
  end

  def add_panda(panda)
    raise 'PandaAlreadyThere' if network.include? panda
    network << panda
  end

  def has_panda(panda)
  end
end

network = PandaSocialNetwork.new
ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
rado = Panda.new("Rado", "rado@pandamail.com", "male")


network.add_panda(ivo)
network.add_panda(rado)
