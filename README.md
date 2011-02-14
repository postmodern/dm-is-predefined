# dm-is-predefined

* [github.com/postmodern/dm-is-predefined](http://github.com/postmodern/dm-is-predefined)
* [github.com/postmodern/dm-is-predefined/issues](http://github.com/postmodern/dm-is-predefined/issues)
* Postmodern (postmodern.mod3 at gmail.com)

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
  
    Licence.gpl2
    # => #<Licence: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">
  
    Licence.predefined_resource(:mit)
    # => #<Licence: id: 2, name: "MIT">

    License.predefined_resource_with(:name => 'GPL-2')
    # => #<License: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

    License.predefined_names
    # => [:gpl2, :mit]

## Requirements

* [dm-core](http://github.com/datamapper/dm-core/) ~> 1.0

## Install

    $ sudo gem install dm-is-predefined

## License

See {file:LICENSE.txt} for license information.

