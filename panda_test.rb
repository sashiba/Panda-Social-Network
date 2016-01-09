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

end