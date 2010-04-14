require 'rubygems'
require 'rake'
require './lib/dm-predefined/version.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'dm-predefined'
    gem.version = DataMapper::Predefined::VERSION
    gem.license = 'MIT'
    gem.summary = %Q{A DataMapper plugin for adding predefined resources to Models.}
    gem.description = %Q{A DataMapper plugin for adding predefined resources to Models.}
    gem.email = 'postmodern.mod3@gmail.com'
    gem.homepage = 'http://github.com/postmodern/dm-predefined'
    gem.authors = ['Postmodern']
    gem.add_dependency 'dm-core', '>= 0.10.2'
    gem.add_development_dependency 'rspec', '>= 1.3.0'
    gem.add_development_dependency 'yard', '>= 0.5.3'
    gem.has_rdoc = 'yard'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :spec => :check_dependencies
task :default => :spec

begin
  require 'yard'

  YARD::Rake::YardocTask.new
rescue LoadError
  task :yard do
    abort "YARD is not available. In order to run yard, you must: gem install yard"
  end
end
