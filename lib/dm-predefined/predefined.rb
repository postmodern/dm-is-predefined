require 'dm-predefined/exceptions/unknown_resource'

module DataMapper
  module Predefined
    ##
    # fired when your plugin gets included into Resource
    #
    def self.included(base)
    end

    def is_predefined
      # Add class-methods
      base.extend  DataMapper::Predefined::ClassMethods
    end

    module ClassMethods
      def [](name)
        name = name.to_sym
        attributes = predefined_attributes[name]

        unless attributes
          raise(UnknownResource,"the resource '#{name}' was not predefined",caller)
        end

        first_or_create(predefined_attributes[name.to_sym])
      end

      protected

      def predefined_attributes
        @@predefined_attributes ||= {}
      end

      def define(name,attributes={})
        name = name.to_sym

        predefined_attributes[name] = attributes

        module_eval %{
          def #{name}
            predefined(:#{name})
          end
        }

        attributes
      end
    end # ClassMethods
  end # Predefined
end # DataMapper
