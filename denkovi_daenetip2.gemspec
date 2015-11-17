Gem::Specification.new do |s|
  s.name        = 'denkovi_daenetip2'
  s.version     = '0.0.2'
  s.date        = '2015-11-17'
  s.summary     = "SNMP gem to use with your DENKOVI DAENETIP2!"
  s.description = "Simple commands to retrieve state"
  s.authors     = ["Pablo Carrillos"]
  s.email       = 'pablocarrillos@gmail.com'
  s.files       = ["lib/denkovi_daenetip2.rb"]
  s.homepage    = 'https://github.com/webpau/denkovi_daenetip2'
  s.add_runtime_dependency 'snmp'
  s.license       = 'MIT'
end
