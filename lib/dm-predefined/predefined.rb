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
          raise(UnknownResource,"The resource '#{name}' was not predefined",caller)
        end

        self.first_or_create(attributes)
      end

      #
      # Finds or auto-creates the predefined resource which shares the
      # given attributes.
      #
      # @param [Hash{Symbol => Object}] desired_attributes
      #   The attribute names and values that the predefined resource
      #   should shared.
      #
      # @return [Object]
      #   The predefined resource.
      #
      # @raise [UnknownResource]
      #   Could not find a predefined resource that shared all of the
      #   desired attributes.
      #
      # @since 0.2.1
      #
      def predefined_resource_with(desired_attributes={})
        self.predefined_attributes.each do |name,attributes|
          shares_attributes = desired_attributes.all? do |key,value|
            key = key.to_sym

            attributes.has_key?(key) && (attributes[key] == value)
          end

          return predefined_resource(name) if shares_attributes
        end

        raise(UnknownResource,"Could not find a predefined resource which shared the given attributes",caller)
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
