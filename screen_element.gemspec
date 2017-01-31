Gem::Specification.new do |s|
  s.name            = 'screen_element'
  s.version         = '0.0.1'
  s.date            = '2017-01-27'
  s.summary         = 'Screen Element'
  s.description     = 'A lib to create screen elements that can be used with Appium or Calabash automation'
  s.authors         = ['Oscar Tanner']
  s.email           = 'oscarpanda@gmail.com'
  s.homepage        = 'http://rubygems.org/gems/screen_element'
  s.license         = 'MIT'

  s.files           = `git ls-files`.split($RS)
  s.require_paths   = ['lib']
  s.test_files      = s.files.grep(%r{^(test|spec|features)/})

  s.add_runtime_dependency 'rake', ['>= 12.0.0']
  s.add_runtime_dependency 'require_all', ['>= 1.4.0']
  s.add_runtime_dependency 'appium_lib', ['>= 9.3.0']

  s.add_development_dependency 'rspec', ['>= 3.5.0']
end
