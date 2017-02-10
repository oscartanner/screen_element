module ScreenElement
  module AppiumEnv   
    class BaseScreen
      class << self
        def element(name, type = :pending, identificator = '')
          define_method(name.to_s) { Element.new type, identificator }
        end
      end

      def initialize(opt = {})
        check_trait opt
      end

      def check_trait(opt)
        raise "#{self.class} not found" unless trait.visible?(opt)
      end

      def message(message)
        Element.new(:text, message)
      end
    end
  end
end
