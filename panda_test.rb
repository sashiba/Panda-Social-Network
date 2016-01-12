require 'minitest/autorun'

require_relative 'panda.rb'

class PandaClass < Minitest::Test
  def  test_panda_name
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")

    assert_equal "Ivo", ivo.name
  end

  def  test_panda_email
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")

    assert_equal "ivo@pandamail.com", ivo.email
  end

  def  test_panda_gender
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")

    assert_equal "male", ivo.gender
  end

  def  test_panda_gender_male?
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")

    assert_equal true, ivo.male?
  end

  def  test_panda_gender_female?
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")

    assert_equal false, ivo.female?
  end

  def  test_panda_to_s
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    expected = "Name: Ivo, Email: ivo@pandamail.com, Gender: male"

    assert_equal expected, ivo.to_s
  end
end

class SocialNetworkClass < Minitest::Test
  def test_add_panda_to_the_network
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@pandamail.com", "female")

    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)

    assert_equal 3, network.size
  end

  def test_has_panda_method_with_existing_panda
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    network.add_panda(ivo)

    assert_equal true, network.has_panda(ivo)
  end

  def test_has_panda_with_nonexistent_panda
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)

    assert_equal false, network.has_panda(rado)
  end

  def test_make_panda_friends
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)
    network.make_friends(ivo, rado)

    assert_equal 1, rado.friends.size
  end

  def test__connection_level_1
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)

    network.make_friends(ivo, rado)
    network.connection_level(ivo, rado)

    assert_equal 1, network.connection_level(ivo, rado)
  end

  def test__connection_level_2
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@gmail.com", "female")
    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)

    network.make_friends(ivo, rado)
    network.make_friends(rado, tony)

    assert_equal 2, network.connection_level(ivo, tony)
  end

  def test__connection_level_no_connection
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@gmail.com", "female")
    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)

    network.make_friends(rado, tony)

    assert_equal -1, network.connection_level(ivo, tony)
  end

  def test__connection_level_with_a_panda_not_in_network
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)

    assert_equal false, network.connection_level(ivo, rado)
  end

  def test_are_friends_method
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)
    network.make_friends(ivo, rado)

    assert_equal true, network.are_friends(ivo, rado)
  end

  def test_are__not_friends_method
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)

    assert_equal false, network.are_friends(ivo, rado)
  end

  def test_are_connected
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)
    network.make_friends(ivo, rado)

    assert_equal true, network.are_connected(ivo, rado)
  end

  def test_are_connected_between_friends
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@gmail.com", "female")

    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)

    network.make_friends(ivo, rado)
    network.make_friends(rado, tony)

    assert_equal true, network.are_connected(ivo, tony)
  end

  def test_are_not_connected
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(ivo)
    network.add_panda(rado)

    assert_equal false, network.are_friends(ivo, rado)
  end

  def test_friends_of_panda_not_from_network
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(rado)

    assert_equal false, network.friends_of(ivo)
  end

  def test_friends_of_panda_in_network
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    network.add_panda(rado)
    network.add_panda(ivo)
    network.make_friends(ivo, rado)

    expected = "Name: Rado, Email: rado@pandamail.com, Gender: male"

    assert_equal expected, network.friends_of(ivo)[0].to_s
  end

  def test_how_many_gender_in_network
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@gmail.com", "female")
    maria = Panda.new("Maria", "mmm@gmail.com", "female")

    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)
    network.add_panda(maria)

    network.make_friends(ivo, rado)
    network.make_friends(rado, tony)
    network.make_friends(rado, maria)

    assert_equal 2, network.how_many_gender_in_network(1, rado, "female")
  end

  def test_how_many_gender_in_network_level_2
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@gmail.com", "female")
    maria = Panda.new("Maria", "mmm@gmail.com", "female")

    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)
    network.add_panda(maria)

    network.make_friends(ivo, rado)
    network.make_friends(rado, tony)
    network.make_friends(rado, maria)

    assert_equal 2, network.how_many_gender_in_network(2, ivo, "female")
  end

  def test_how_many_gender_in_network_0_females
    network = PandaSocialNetwork.new
    ivo = Panda.new("Ivo", "ivo@pandamail.com", "male")
    rado = Panda.new("Rado", "rado@pandamail.com", "male")
    tony = Panda.new("Tony", "tony@gmail.com", "female")
    maria = Panda.new("Maria", "mmm@gmail.com", "female")

    network.add_panda(ivo)
    network.add_panda(rado)
    network.add_panda(tony)
    network.add_panda(maria)

    network.make_friends(ivo, rado)
    network.make_friends(rado, tony)
    network.make_friends(rado, maria)

    assert_equal 0, network.how_many_gender_in_network(1, ivo, "female")
  end
end
