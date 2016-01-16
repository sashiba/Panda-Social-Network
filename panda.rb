module PandaSocialNetwork
  require 'json'
  require 'yaml'

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
      name == other.name && email == other.email && gender == other.gender
    end

    def hash
      to_s.hash
    end

    def to_yaml
      YAML.dump({ name: @name,
                  email: @email,
                  gender: @gender,
                  friends: @friends
                })
    end

    def self.from_yaml(string)
      data = YAML.load string
      self.new(data[:name], data[:email], data[:gender])
      #self.friends = data[:friends]
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

      panda2.friends << panda1 unless panda2.friends.include? panda1
      panda1.friends << panda2 unless panda1.friends.include? panda2
    end

    def are_friends(panda1, panda2)
      panda1.friends.include?(panda2) && panda2.friends.include?(panda1)
    end

    def friends_of(panda)
      return false unless has_panda(panda)

      panda.friends
    end

    def connection_level(panda1, panda2)
      return false unless has_panda(panda1) && has_panda(panda2)
      levels = bfs_1(panda1, panda2)

      levels
    end

    def bfs_1(start_panda, wanted_panda)
      q = Queue.new
      visited = []
      q << [0, start_panda]
      visited << start_panda

      until q.empty?
        level, current = q.pop
        return level if wanted_panda == current

        un = network[current].select { |v| !visited.include? v }
        un.each do |v|
          visited << v
          q << [level + 1, v]
        end
      end

      -1
    end

    def are_connected(panda1, panda2)
      return false unless connection_level(panda1, panda2)

      connection_level(panda1, panda2) == -1 ? false : true
    end

    def bfs_gender_on_level(start_panda, search_level, gender)
      q = Queue.new
      visited, result = [], 0
      q << [0, start_panda]
      visited << start_panda

      until q.empty?
        level, current = q.pop
        result += 1 if level == search_level && gender == current.gender

        un = network[current].select { |v| !visited.include? v }
        un.each do |v|
          visited << v
          q << [level + 1, v]
        end
      end

      result
    end

    def how_many_gender_in_network(level, panda, gender)
      bfs_gender_on_level(panda, level, gender)
    end

    def size
      network.size
    end

    def save(file_name)
      File.open("#{file_name}.psn", 'w+') { |f| Marshal.dump(self, f) }
    end

    def load(file_name)
      File.open("#{file_name}.psn", 'r') { |f| Marshal.load(f) }
    end

    def to_json
      pandas_array = []
      @network.each do |panda, _|
        p panda
        pandas_array << {
          name: panda.name, email: panda.email,
          gender: panda.gender, friends: panda.friends
        }
      end
      { network: @network, pandas: pandas_array }
    end

    def json_create(network_json)
      @network = network_json['network']
    end

    def json_load(file_name)
      result = ''
      File.open(file_name, 'r') do |file|
        file.each_line { |line| result << line }
      end

      JSON.load result
    end

    def save_json(file_name)
      File.open("#{file_name}.json", 'w+') do |file|
        file << (JSON.dump network.to_json)
      end
    end

    def to_yaml
      YAML.dump network.each(&:to_yaml)
    end

    def self.from_yaml(string)
    end
  end
end
