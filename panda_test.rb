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
    expected = "Name: Ivo, email: ivo@pandamail.com, gender: male"

    assert_equal expected, ivo.to_s
  end
end
