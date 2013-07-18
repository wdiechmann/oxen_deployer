Gem::Specification.new do |s|
  s.name        = 'oxen_deployer'
  s.version     = '1.0.2'
  s.date        = '2013-07-18'
  s.summary     = "OxenDeployer - Vlad with a vengeance"
  s.description = "OxenDeployer was born out of desperation with Vlad accepting commits"
  s.authors     = ["Walther Diechmann", "Enrique Phillips"]
  s.email       = ['walther@diechmann.net', 'enrique.phillips.wac@gmail.com']
  s.files       = ["lib/oxen_deployer.rb", "lib/oxen_deployer/apache.rb", "lib/oxen_deployer/core.rb", "lib/oxen_deployer/maintenance.rb", "lib/oxen_deployer/passenger.rb", "lib/oxen_deployer/rails.rb", "lib/oxen_deployer/subversion.rb"]
  s.homepage    = 'https://github.com/wdiechmann/oxen_deployer'

  s.add_runtime_dependency('rake-remote_task', "~> 2.1")
  # 
  # s.add_development_dependency('hoe', "~> 2.12")
  # s.add_development_dependency('minitest')
  # s.add_development_dependency('mocha')
  # s.add_development_dependency('hoe-doofus')
  # s.add_development_dependency('hoe-git')
  
end