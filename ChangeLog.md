### 0.3.1 / 2011-02-28

* Require dm-core ~> 1.0.
* Switched from Jeweler to [Ore](http://github.com/ruby-ore/ore#readme).
* Upgraded to RSpec2.

### 0.3.0 / 2010-07-08

* Require DataMapper 1.0.0.
* Renamed dm-predefined to dm-is-predefined.
* Renamed `DataMapper::Predefined` to {DataMapper::Is::Predefined}.

### 0.2.3 / 2010-04-01

* Store the predefined attributes in an instance variable in the Model.

### 0.2.2 / 2010-03-20

* Switched to Jeweler for the building and releasing of RubyGems.
* Split `dm-predefined/yard` out into the `yard-dm-predefined` library.
* Require dm-core >= 0.10.2.
* Renamed `DataMapper::Predefined::ClassMethods#[]` to
  `DataMapper::Predefined::ClassMethods#predefined_resource`.
* Added `DataMapper::Predefined::ClassMethods#predefined_names`.
* Added `DataMapper::Predefined::ClassMethods#predefined_resource_with`.
* Added more specs.

### 0.2.0 / 2009-09-21

* Require Hoe >= 2.3.3.
* Require YARD >= 0.2.3.5.
* Require dm-core >= 0.10.0.
* Moved to YARD based documentation.
* Added YARD handlers for documenting +predefine+ method-calls.
* Renamed Predefined.predefined to Predefined.predefine.

### 0.1.1 / 2009-01-17

* Fixed specs to work with RSpec 1.1.12.
* All specs pass in Ruby 1.9.1-rc1.

### 0.1.0 / 2008-12-21

* Initial release.

