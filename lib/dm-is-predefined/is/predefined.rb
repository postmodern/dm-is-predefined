require 'dm-is-predefined/is/exceptions/unknown_resource'

module DataMapper
  module Is
    module Predefined
      #
      # Fired when your plugin gets included into a Model.
      #
      def is_predefined
        extend DataMapper::Is::Predefined::ClassMethods
      end

      module ClassMethods
        #
        # All pre-defined resources of the model.
        #
        # @return [Hash{Symbol => Hash}]
        #   The Hash of pre-defined resources and their attributes.
        #
        def predefined_attributes
          @predefined_attributes ||= {}
        end

        #
        # Returns the names of the predefined resources.
        #
        # @return [Array<Symbol>]
        #   The names of the predefined resources.
        #
        # @since 0.4.0
        #
        def predefined
          predefined_attributes.keys
        end

        #
        # @see #predefined
        #
        # @deprecated Will be removed in 1.0.0.
        #
        # @since 0.2.1
        #
        def predefined_names
          predefined
        end

        #
        # Determines if a resource was predefined.
        #
        # @param [Symbol, String] name
        #   The name of the predefined resource to search for.
        #
        # @return [Boolean]
        #   Specifies whether the resource was predefined.
        #
        # @since 0.4.0
        #
        def predefined?(name)
          predefined_attributes.has_key?(name.to_sym)
        end

        #
        # Finds or auto-creates the pre-defined resource with the given
        # name.
        #
        # @param [Symbol, String] name
        #   The name of the pre-defined resource.
        #
        # @param [Hash{Symbol => Object}] extra_attributes
        #   Additional attributes to add to the predefined resource.
        #
        # @return [DataMapper::Resource]
        #   The pre-defined resource.
        #
        # @raise [UnknownResource]
        #   Indicates that there are no predefined attributes for the
        #   resource with the given name.
        #
        # @since 0.2.1
        #
        def predefined_resource(name)
          name = name.to_sym

          unless predefined?(name)
            raise(UnknownResource,"The resource '#{name}' was not predefined")
          end

          return first_or_create(predefined_attributes[name])
        end

        #
        # Finds or auto-creates the predefined resource which shares the
        # given attributes.
        #
        # @param [Hash{Symbol => Object}] query
        #   The attribute names and values that the predefined resource
        #   should shared.
        #
        # @return [DataMapper::Resource]
        #   The predefined resource.
        #
        # @raise [UnknownResource]
        #   Could not find a predefined resource that shared all of the
        #   desired attributes.
        #
        # @since 0.4.0
        #
        def first_predefined_resource(query={})
          if (resource = first(query))
            return resource
          end

          # if the resource wasn't found, search for matching
          # predefined attributes
          attributes = predefined_attributes.values.find do |attributes|
            query.all? { |k,v| attributes.has_key?(k) && attributes[k] == v }
          end

          # create the resource using the predefined attributes
          return create(attributes) if attributes

          # no pre-existing or predefined resource matching the query
          raise(UnknownResource,"Could not find a predefined resource which shared the given attributes")
        end

        #
        # @since 0.2.1
        #
        # @deprecated
        #   Will be removed in 1.0.0. Please use {#first_predefined_resource}
        #   instead.
        #
        def predefined_resource_with(query={})
          first_predefined_resource(query)
        end

        #
        # Allows transparently getting predefined resources, alongwith
        # existing resources.
        #
        # @param [Symbol, Object] key
        #   The name of the predefined resource or primary-key of a
        #   pre-existing resource.
        #
        # @return [DataMapper::Resource, nil]
        #   The matching resource.
        #
        # @since 0.4.0
        #
        # @api public
        #
        def get(key)
          if key.kind_of?(Symbol)
            predefined_resource(key)
          else
            super(key)
          end
        end

        protected

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
        #   The attributes that will be assigned to the pre-defined
        #   resource.
        #
        def predefine(name,attributes={})
          name = name.to_sym

          if attributes.empty?
            raise(ArgumentError,"Cannot predefine a resource with no attributes")
          end

          predefined_attributes[name] = attributes

          class_eval %{
            class << self
              define_method(#{name.inspect}) { get(#{name.inspect}) }
            end
          }

          return attributes
        end
      end # ClassMethods
    end # Predefined
  end # Is
end # DataMapper
