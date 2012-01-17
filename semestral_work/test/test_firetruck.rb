require 'test/unit'
require 'lib/firetruck'
class TestFiretruck < Test::Unit::TestCase

  def setup
    town=Town.new
  end

	def test_right_output
    input=StringIO.new(File.read('test_firetruck_1.txt'))
    output=StringIO.new(File.read('test_firetruck_1_sol.txt'))
    town.read(input)
		assert_equal(output, town.process)
  end

  def test_wrong_input_format
    input=StringIO.new(File.read('test_firetruck_2.txt'))
    assert_raise( ArgumentError ) { town.read(input) }
  end

  def test_wrong_input_values
    input=StringIO.new(File.read('test_firetruck_3.txt'))
    assert_raise( ArgumentError ) { town.read(input) }
  end

  def teardown

  end

end