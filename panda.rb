class Panda

  attr_accessor :name, :email, :gender, :friends

  def initialize(name, email, gender)
    @name = name
    @email = email
    @gender = gender
    @friends = []
  end

  def male?
    gender == 'male'
  end

  def female?
    gender == 'female'
  end

  def to_s
    "Name: #{name}, Email: #{email}, Gender: #{gender}"
  end

  def to_proc
    lambda do |x, *args|
      x.public_send self, *args
    end
  end

  def ==(other)
    name == other.name and email == other.email and gender == other.gender
  end

  def hash
    to_s.hash
  end

  alias_method :eql?, :==
end

class PandaSocialNetwork

  attr_accessor :network

  def initialize
    @network = {}
  end

  def add_panda(panda)
    raise "PandaAlreadyThere" if has_panda(panda)

    network[panda] = panda.friends
  end

  def has_panda(panda)
    return true if network.key? panda

    false
  end

  def make_friends(panda1, panda2)
    raise "PandasAlreadyFriends" if are_friends(panda1, panda2)

    add_panda(panda1) unless has_panda(panda1)
    add_panda(panda2) unless has_panda(panda2)

    unless panda2.friends.include? panda1
      panda2.friends << panda1
    end
    unless panda1.friends.include? panda2
      panda1.friends << panda2
    end
  end

  def are_friends(panda1, panda2)
    panda1.friends.include?(panda2) && panda2.friends.include?(panda1)
  end

  def friends_of(panda)
    return false unless has_panda(panda)

    panda.friends
  end

  def connection_level(panda1, panda2)
    return false unless has_panda(panda1) or has_panda(panda2)
    levels = bfs(network, panda1, panda2).size

    return -1 if levels == 0

    levels
  end

  def bfs(network, panda1, panda2)
    queue = [panda1]
    visited = []


    while !queue.empty? or current_panda != panda2
      current_panda = queue.shift

      unless result.include? current_panda
        result << current_panda
        current_panda.friends.each do |current_friend|
          queue << current_friend
        end
      end
    end

    if queue.empty?
      visited == []
    else
      visited << panda2
    end

    visited
  end

  def are_connected(panda1, panda2)
    return false unless connection_level(panda1, panda2)

    connection_level(panda1, panda2) == -1 ? false : true
  end

  def how_many_gender_in_network(level, panda, gender)
  end

  def size
    network.size
  end
end

network = PandaSocialNetwork.new
ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
rado = Panda.new("Rado", "rado@pandamail.com", "male")
sasho = Panda.new("Sasho", "sasho@gmail.com", "male")
mila = Panda.new("Mila", "msruseva@gmail.com", "female")


p ivo.to_proc
