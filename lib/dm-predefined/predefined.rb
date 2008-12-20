module DataMapper
  module Predefined

    ##
    # fired when your plugin gets included into Resource
    #
    def self.included(base)
      # Add class-methods
      base.extend  DataMapper::Predefined::ClassMethods
    end

    module ClassMethods
      def predefined(name)
        first_or_create(defined_resources[name.to_sym])
      end

      protected

      def defined_resources
        @@defined_resources ||= {}
      end

      def define(name,attributes={})
        name = name.to_sym

        defined_resources[name] = attributes

        class_eval %{
            def #{name}
              predefined(:#{name})
            end
        }

        attributes
      end
    end # ClassMethods
  end # Predefined
end # DataMapper
