spec = Gem::Specification.new do |s|
  s.name = "filtration"
  s.version = "0.0.5"
  s.author = "R. Scott Reis"
  s.platform = Gem::Platform::RUBY
  s.summary = "Filtration enables pre/post method callback, similar to Python decorators"
  s.require_path = "lib"
  s.has_rdoc = true
  s.rdoc_options << '-m' << 'README.rdoc' << '-t' << 'Filtration'
  s.extra_rdoc_files = ["README.rdoc"]
  
  s.files =  %w[
    LICENSE
    README.rdoc
    ] + Dir['lib/**/*.rb']
  
  s.test_files = Dir['spec/*.rb']
end
