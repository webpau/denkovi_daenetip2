require 'snmp'

#dae = DaenetIP2.new("164.0.0.177",161,"","")

class DaenetIP2
  attr_accessor :ip, :port, :read_pass, :write_pass

  ::WRITE_PORT_P3 = '1.3.6.1.4.1.19865.1.2.1.'
  ::WRITE_PORT_P5 = '1.3.6.1.4.1.19865.1.2.2.'
  ::READ_PORT6 = '1.3.6.1.4.1.19865.1.2.3.'
  ::READ_ALL = '1.3.6.1.4.1.19865.1.2.3.33.0'

  #Creates a SNMP Manager
  def initialize(ip, port, read_pass, write_pass)
	  self.ip = ip
  	self.port = port
	  self.read_pass = read_pass
	  self.write_pass = write_pass
    puts 'to create manager'
    begin
      @manager = SNMP::Manager.new(:host => self.ip, :port => self.port.to_i, :community => self.read_pass, :write_community => self.write_pass, :version => :SNMPv1)
      puts "manager created"
      true
    rescue
      false
    end
  end

  # To read relay state
  # @param relay [Integer] The relay number: 1-8
  # @return [Integer] success or not
  def read(input)
    begin
      puts "to read value: " + input.to_s
      response = @manager.get(DaenetIP2::READ_PORT6 +  input.to_s + '.0')
      return response.varbind_list[0].value.to_i
    rescue => e
      puts "Exception: " + e.message
      nil
    end
  end

  # To change relay state
  # @param port [String] port 'p3' or 'p5'
  # @param relay [Integer] The relay number: 0-15
  # @param value [Integer] Relay new state: 0-1
  # @return [Boolean] success or not
  def write(port, relay, value)
    begin
      puts "relay: " + relay.to_s + " value: " + value.to_s
      if port == 'p3'
        varbind = SNMP::VarBind.new(DaenetIP2::WRITE_PORT_P3 + relay.to_s + ".0", SNMP::Integer.new(value.to_i))
      end
      if port == 'p5'
        varbind = SNMP::VarBind.new(DaenetIP2::WRITE_PORT_P5 + relay.to_s + ".0", SNMP::Integer.new(value.to_i))
      end

      begin
        puts "to set to relay " + relay.to_s + " value " + value.to_s
        @manager.set(varbind)
        true
      rescue
        false
      end
    rescue => e
      puts "Exception in write: " + e.message
      false
    end
  end

  #To read all input
  #@return [Integer]
  def read_all
    begin
      response = @manager.get(DaenetIP2::READ_ALL)
      response.varbind_list[0].value.to_i
    rescue Exception => e
      puts "Exception: " + e.message
       nil
    end
  end

  #To close manager
  def close
    begin
      @manager.close
      true
    rescue Exception => e
      puts "Exception: " + e.message
      false
    end
  end

end
