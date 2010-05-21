require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'dm-is-predefined'
  gem.license = 'MIT'
  gem.summary = %Q{A DataMapper plugin for adding predefined resources to Models.}
  gem.description = %Q{A DataMapper plugin for adding predefined resources to Models.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/postmodern/dm-is-predefined'
  gem.authors = ['Postmodern']
  gem.has_rdoc = 'yard'
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
