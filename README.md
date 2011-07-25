# dm-is-predefined

* [Source](http://github.com/postmodern/dm-is-predefined)
* [Issues](http://github.com/postmodern/dm-is-predefined/issues)
* [Documentation](http://rubydoc.info/gems/dm-is-predefined/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

A DataMapper plugin for adding predefined resources to Models.

## Example

    require 'dm-core'
    require 'dm-is-predefined'
  
    class Licence
  
      include DataMapper::Resource

      is :predefined
    
      # Name of the Licence
      property :name, String
    
      # URL to the licence
      property :url, String
    
      predefine :gpl2,
                :name => 'GPL-2',
                :url => 'http://www.gnu.org/copyleft/gpl.html'

      predefine :mit, :name => 'MIT'
  
    end
  
 
    License.predefined?(:gpl2)
    # => true

    License.predefined
    # => [:gpl2, :mit]

    Licence.predefined_resource(:mit)
    # => #<Licence: id: 2, name: "MIT">

    License.first_predefined_resource(:name => 'GPL-2')
    # => #<License: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

    Licence.gpl2
    # => #<Licence: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

## Requirements

* [dm-core](http://github.com/datamapper/dm-core/) ~> 1.0

## Install

    $ sudo gem install dm-is-predefined

## License

Copyright (c) 2008-2011 Hal Brodigan

See {file:LICENSE.txt} for license information.
