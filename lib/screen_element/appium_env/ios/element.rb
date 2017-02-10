module ScreenElement
  module AppiumEnv
    module Ios
      class Element < BaseElement
        def enter(text, opt = {})
          close_keyboard = opt.fetch(:close_keyboard, false)
          close_keyboard_button = opt.fetch(:close_keyboard_button, nil)
          super text, opt
          begin
            if close_keyboard 
              if close_keyboard_button.nil?
                hide_ios_keyboard
              else
                close_keyboard_button.touch
              end
            end
          rescue
            # If an error occurs here, is because the keyboard is already hidden
          end
        end
      end
    end
  end
end