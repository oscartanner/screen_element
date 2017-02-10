module ScreenElement
  module AppiumEnv
    module Android
      class Element < BaseElement
        def enter(text, opt = {})
          close_keyboard = opt.fetch(:close_keyboard, false)
          super text, opt
          begin
            hide_keyboard if close_keyboard
          rescue
            # If an error occurs here, is because the keyboard is already hidden
          end
        end
      end
    end
  end
end