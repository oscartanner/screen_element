module ScreenElement
  module CalasbashEnv
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

      def drag_to(element)
        until element.visible?
          trait.drag(delta_y: 50)
          sleep 2
        end
      end
    end
  end
end
end


