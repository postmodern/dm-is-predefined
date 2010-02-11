# dm-predefined

* [dm-predefined.rubyforge.org](http://dm-predefined.rubyforge.org/)
* [github.com/postmodern/dm-predefined](http://github.com/postmodern/dm-predefined)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

A DataMapper plugin for adding predefined resources to Models.

## Example

    require 'dm-core'
    require 'dm-predefined'
  
    class Licence
  
      include DataMapper::Resource
      include DataMapper::Predefined
    
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

    License.predefined_names
    # => [:gpl2, :mit]

## Requirements

* [dm-core](http://github.com/datamapper/dm-core/) >= 0.10.2

## Install

    $ sudo gem install dm-predefined

## License

See {file:LICENSE.txt} for license information.

