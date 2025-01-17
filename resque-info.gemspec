lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque-info/version'

Gem::Specification.new do |spec|
  spec.name          = 'resque-info'
  spec.version       = '0.0.2'
  spec.authors       = ['Rahul Patil']
  spec.email         = ['rahupatil_scs@yahoo.co.in']
  spec.summary       = 'Resque Info'
  spec.description   = 'Resque Info'
  spec.homepage      = 'https://github.com/rpatil/resque-info'
  spec.license       = 'MIT'
  spec.date          = '2024-12-31'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.files = Dir['README.md', 'Gemfile', 'Rakefile', 'spec/*', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
end
