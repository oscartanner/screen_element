module ScreenElement
  module AppiumEnv
    module ElementModule
      module ClassMethods
        def element(name, type = :pending, identificator = '')
          define_method(name.to_s) do
            ScreenElement::AppiumEnv::Element.new type, identificator
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end
    end
  end
end
