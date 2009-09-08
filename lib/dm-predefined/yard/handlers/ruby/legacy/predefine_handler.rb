require 'yard'

module YARD
  module Handlers
    module Ruby
      module Legacy
        class PredefineHandler < Base

          handles /\Apredefine\s/

          def process
            nobj = namespace
            name = statement.tokens[2,1].to_s[1..-1]

            register MethodObject.new(nobj, name, :class) do |o|
              o.visibility = :public
              o.source = statement.source
              o.signature = "def #{nobj}.#{name}"
            end
          end

        end
      end
    end
  end
end
