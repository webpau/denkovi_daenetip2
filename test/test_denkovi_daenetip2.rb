require 'minitest/autorun'
require 'denkovi_daenetip2'

class DenkoviDaenetip2Test < Minitest::Test

  ::TEST_IP = '164.0.0.177'
  ::TEST_PORT = 161
  ::TEST_READ_PASS = ''
  ::TEST_WRITE_PASS = ''

  def test_initialize
    assert_instance_of DaenetIP2, DaenetIP2.new(TEST_IP, TEST_PORT, TEST_READ_PASS, TEST_WRITE_PASS)
  end

  def test_close
    dae = DaenetIP2.new(TEST_IP, TEST_PORT, TEST_READ_PASS, TEST_WRITE_PASS)
    assert dae.close
  end

  def test_read_all
    dae = DaenetIP2.new(TEST_IP, TEST_PORT, TEST_READ_PASS, TEST_WRITE_PASS)
    assert_instance_of Fixnum, dae.read_all
  end  

  def test_write
    dae = DaenetIP2.new(TEST_IP, TEST_PORT, TEST_READ_PASS, TEST_WRITE_PASS)
    assert dae.write('p5', 1, 0)
  end
 
end