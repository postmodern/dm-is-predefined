require 'dm-is-predefined/is/exceptions/unknown_resource'

module DataMapper
  module Is
    module Predefined
      #
      # Fired when your plugin gets included into a Model.
      #
      # @note
      #   If the model already includes `DataMapper::Migrations`, then
      #   {MigrationMethods} will be extended into the Model.
      #
      # @api private
      #
      def is_predefined
        extend DataMapper::Is::Predefined::ClassMethods

        if defined?(DataMapper::Migrations) &&
           included_modules.include?(DataMapper::Migrations)
          extend MigrationMethods
        end
      end

      #
      # @since 0.4.0
      #
      module MigrationMethods
        #
        # Auto-migrates the model, then creates all predefined resources.
        #
        # @param [Symbol] repository_name
        #   The repository to perform the migrations within.
        #
        # @return [true]
        #
        # @api public
        #
        def auto_migrate!(repository_name=self.repository_name)
          result = super(repository_name)

          predefine!(repository_name)
          return result
        end

        #
        # Auto-upgrades the model, then creates any missing predefined
        # resources.
        #
        # @param [Symbol] repository_name
        #   The repository to perform the upgrade within.
        #
        # @return [true]
        #
        # @api public
        #
        def auto_upgrade!(repository_name=self.repository_name)
          result = super(repository_name)

          predefine!(repository_name)
          return result
        end
      end

      module ClassMethods
        #
        # All pre-defined resources of the model.
        #
        # @return [Hash{Symbol => Hash}]
        #   The Hash of pre-defined resources and their attributes.
        #
        # @api semipublic
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
        # @api public
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
        # @api public
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
        # @api public
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
        # @deprecated
        #   Will be removed in 1.0.0. Instead, search {#predefined_attributes}
        #   directly.
        #
        # @since 0.2.1
        #
        # @api public
        #
        def predefined_resource_with(query={})
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
        # Creates the predefined resources.
        #
        # @param [Symbol] repository_name
        #   The repository to perform the upgrade within.
        #
        # @since 0.4.0
        #
        # @api public
        #
        def predefine!(repository_name=self.repository_name)
          DataMapper.repository(repository_name) do
            predefined_attributes.each_value do |attributes|
              first_or_create(attributes)
            end
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
        # @api public
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
