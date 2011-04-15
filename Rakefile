require 'rspec/core/rake_task'

desc "Run all specs"
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = '--format documentation'
  t.skip_bundler = true
end

task :default => :rspec