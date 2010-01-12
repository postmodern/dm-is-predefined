require 'dm-predefined/exceptions/unknown_resource'

module DataMapper
  module Predefined
    #
    # Fired when your plugin gets included into Resource.
    #
    def self.included(base)
      base.extend DataMapper::Predefined::ClassMethods
    end

    module ClassMethods
      #
      # Returns the names of the predefined resources.
      #
      # @return [Array<Symbol>]
      #   The names of the predefined resources.
      #
      # @since 0.2.1
      #
      def predefined_names
        predefined_attributes.keys
      end

      #
      # Finds or auto-creates the pre-defined resource with the given name.
      #
      # @param [Symbol, String] name
      #   The name of the pre-defined resource.
      #
      # @return [Object]
      #   The pre-defined resource.
      #
      # @raise [UnknownResource]
      #   Indicates that there are no predefined attributes for the resource
      #   with the given name.
      #
      # @since 0.2.1
      #
      def predefined_resource(name)
        name = name.to_sym
        attributes = self.predefined_attributes[name]

        unless attributes
          raise(UnknownResource,"the resource '#{name}' was not predefined",caller)
        end

        self.first_or_create(attributes)
      end

      protected

      @@predefined_attributes = {}

      #
      # All pre-defined resources of the model.
      #
      # @return [Hash{Symbol => Hash}]
      #   The Hash of pre-defined resources and their attributes.
      #
      def predefined_attributes
        @@predefined_attributes
      end

      #
      # Defines a new pre-defined resource for the model.
      #
      # @param [Symbol, String] name
      #   The name of the pre-defined resource.
      #
      # @param [Hash] attributes
      #   The attributes for the pre-defined resource.
      #
      # @return [Hash]
      #   The attributes that will be assigned to the pre-defined resource.
      #
      def predefine(name,attributes={})
        name = name.to_s

        self.predefined_attributes[name.to_sym] = attributes

        class_eval %{
          class << self
            define_method(#{name.dump}) do
              predefined_resource(#{name.dump})
            end
          end
        }

        attributes
      end
    end # ClassMethods
  end # Predefined
end # DataMapper
