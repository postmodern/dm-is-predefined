# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-predefined}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Postmodern"]
  s.date = %q{2010-03-20}
  s.description = %q{A DataMapper plugin for adding predefined resources to Models.}
  s.email = %q{postmodern.mod3@gmail.com}
  s.extra_rdoc_files = [
    "ChangeLog.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".gitignore",
    ".specopts",
    ".yardopts",
    "ChangeLog.md",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "dm-predefined.gemspec",
    "lib/dm-predefined.rb",
    "lib/dm-predefined/exceptions/unknown_resource.rb",
    "lib/dm-predefined/predefined.rb",
    "lib/dm-predefined/version.rb",
    "spec/integration/models/test_model.rb",
    "spec/integration/predefined_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.has_rdoc = %q{yard}
  s.homepage = %q{http://github.com/postmodern/dm-predefined}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A DataMapper plugin for adding predefined resources to Models.}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/integration/predefined_spec.rb",
    "spec/integration/models/test_model.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, [">= 0.10.2"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_development_dependency(%q<yard>, [">= 0.5.3"])
    else
      s.add_dependency(%q<dm-core>, [">= 0.10.2"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<yard>, [">= 0.5.3"])
    end
  else
    s.add_dependency(%q<dm-core>, [">= 0.10.2"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<yard>, [">= 0.5.3"])
  end
end

