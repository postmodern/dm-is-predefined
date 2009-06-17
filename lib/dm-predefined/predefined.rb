require 'dm-predefined/exceptions/unknown_resource'

module DataMapper
  module Predefined
    ##
    # fired when your plugin gets included into Resource
    #
    def self.included(base)
      base.extend DataMapper::Predefined::ClassMethods
    end

    module ClassMethods
      def self.extended(obj)
        obj.instance_eval do
          @@predefined_attributes = {}
        end
      end

      #
      # Returns the pre-defined model with the specified _name_.
      #
      def [](name)
        name = name.to_sym
        attributes = predefined_attributes[name]

        unless attributes
          raise(UnknownResource,"the resource '#{name}' was not predefined",caller)
        end

        first_or_create(attributes)
      end

      protected

      #
      # Returns the Hash of predefined models and their attributes.
      #
      def predefined_attributes
        @@predefined_attributes
      end

      #
      # Defines a new predefined model with the specified _name_ and
      # the given _attributes_.
      #
      def define(name,attributes={})
        name = name.to_s

        predefined_attributes[name.to_sym] = attributes

        class_eval %{
          class << self
            define_method(#{name.dump}) do
              self[#{name.dump}]
            end
          end
        }

        attributes
      end
    end # ClassMethods
  end # Predefined
end # DataMapper
