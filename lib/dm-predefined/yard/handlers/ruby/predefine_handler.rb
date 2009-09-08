require 'yard'

module YARD
  module Handlers
    module Ruby
      class PredefineHandler < Base

        handles method_call(:predefine)

        def process
          nobj = namespace
          name = if statement.type == :predefine
                   statement.jump(:ident, :op, :kw, :const).source
                 elsif statement.call?
                   obj = statement.parameters(false).first

                   case obj.type
                   when :symbol_literal
                     obj.jump(:ident, :op, :kw, :const).source
                   when :string_literal
                     obj.jump(:string_content).source
                   end
                 end

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
