require 'snmp'

#dae = DaenetIP2.new("164.0.0.177",161,"","")

class DaenetIP2
  attr_accessor :ip, :port, :read_pass, :write_pass

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
      return true
    rescue
      return false
    end
  end

  # To read relay state
  # @param relay [Integer] The relay number: 0-15
  # @return [Integer] success or not
  def read(input)
    begin
      #manager= Manager.new(:host => self.ip, :community => self.snmp_pass, :write_community => self.snmp_pass, :version => :SNMPv1)
      puts "to read value: " + input.to_s
      response = @manager.get('1.3.6.1.4.1.19865.1.2.3.' +  input.to_s + '.0')
      #manager.close
      return response.varbind_list[0].value.to_i
    rescue => e
      puts "Exception: " + e.message
      return nil
    end
  end

  # To change relay state
  # @param relay [Integer] The relay number: 0-15
  # @param value [Integer] Relay new state: 0-1
  # @return [Boolean] success or not
  def write(relay, value)
    begin
    puts "relay: " + relay.to_s + " value: " + value.to_s
    if relay <= 8
      response = @manager.get("1.3.6.1.4.1.19865.1.2.2." + relay.to_s + ".0") #puerto 5
      puts "response: " + response.inspect.to_s
    else
      value = relay.to_i - 8
      puts "value: " + value.to_s
      response = @manager.get("1.3.6.1.4.1.19865.1.2.1." + value.to_s + ".0") #puerto 3
    end

    response.each_varbind do |vb|
      puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"
    end

    if relay.to_i <= 8
      if value == 1
        puts "to create varbind"
        varbind = SNMP::VarBind.new("1.3.6.1.4.1.19865.1.2.2." + relay.to_s + ".0", SNMP::Integer.new(1))
      else
        varbind = SNMP::VarBind.new("1.3.6.1.4.1.19865.1.2.2." + relay.to_s + ".0", SNMP::Integer.new(0))
      end
    else
      if value == 1
        varbind = SNMP::VarBind.new("1.3.6.1.4.1.19865.1.2.1." + value.to_s + ".0", SNMP::Integer.new(1))
      else
        varbind = SNMP::VarBind.new("1.3.6.1.4.1.19865.1.2.1." + value.to_s + ".0",SNMP::Integer.new(0))
      end
    end

    begin
      puts "to set to relay " + relay.to_s + " value " + value.to_s
      @manager.set(varbind)
      return true
    rescue
      return false
    end
    rescue => e
      puts "Exception in write: " + e.message
      return false
    end
  end

  #To read all input
  #@return [Integer]
  def read_all
    begin
      #manager= Manager.new(:host => self.ip, :community => self.snmp_pass, :write_community => self.snmp_pass, :version => :SNMPv1)
      response = @manager.get('1.3.6.1.4.1.19865.1.2.3.33.0')
      #manager.close
      return response.varbind_list[0].value.to_i
    rescue Exception => e
      puts "Exception: " + e.message
      return nil
    end
  end

end
