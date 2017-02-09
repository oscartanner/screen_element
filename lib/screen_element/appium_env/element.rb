module ScreenElement
  module AppiumEnv
    class Element < World
      include OCRHelperModule

      attr_accessor :element

      def initialize(type, identificator)
        case type
        when :desc
          @type = :xpath
          @identificator = "//*[@content-desc='#{identificator}']"
        when :text
          @type = :xpath
          @identificator = "//*[@text='#{identificator}']"
        when :element
          @type = type
          @identificator = identificator
          @element = identificator
        else
          @type = type
          @identificator = identificator
        end
      end

      def visible!(opt = {})
        # For toast elements, we use image recognition to locate messages
        # on the screen
        if @type == :toast
          raise ElementNotFoundError,
                "Element with #{@type}: '#{@identificator}' not found!\n" unless
                  text_in_image?(@identificator)

        else
          timeout = opt.fetch(:timeout, 10)

          begin
            if @type == :array
              wait_true(timeout) { elements.first.displayed? }
            else
              wait_true(timeout) { element.displayed? }
            end
          rescue => e
            raise ElementNotFoundError,
                  "Element with #{@type}: '#{@identificator}' not found!\n#{e.message}"
          end
        end
      end

      def visible?(opt = {})
        begin
          visible!(opt)
        rescue
          return false
        end
        true
      end

      def not_visible!(opt = {})
        timeout = opt.fetch(:timeout, 10)
        begin
          sleep(2) # To avoid flaky tests
          wait_true(timeout) { !exists { element } }
        rescue => e
          raise ElementFoundError,
                "Element with #{@type}: '#{@identificator}' found!\n#{e.message}"
        end
      end

      def not_visible?(opt = {})
        begin
          not_visible!(opt)
        rescue
          return false
        end
        true
      end

      def touch(opt = {})
        visible!(opt)
        element.click
      end

      def drag(opt = {})
        delta_x = opt.fetch(:delta_x, 0)
        delta_y = opt.fetch(:delta_y, 0)
        Appium::TouchAction.new.long_press(element: element)
                           .move_to(x: delta_x, y: delta_y).release.perform
      end

      def swipe(opt = {})
        delta_x = opt.fetch(:delta_x, 0)
        delta_y = opt.fetch(:delta_y, 0)
        location = element.location
        # TODO: Remove global variable $driver
        $driver.swipe(start_x: location[:x], start_y: location[:y],
                      delta_x: delta_x, delta_y: delta_y)
      end

      def enter(text, opt = {})
        close_keyboard = opt.fetch(:close_keyboard, false)

        element.send_keys text
        begin
          hide_keyboard if close_keyboard
        rescue
          # If an error occurs here, is because the keyboard is already hidden
        end
      end

      def checked?
        element.attribute('checked') == 'true'
      end

      # TODO: See if would be nice to implement these methods with method missing
      # to avoid creating all these accessor methods for element attributes
      def text
        element.text
      end

      def element
        @element = elements.first if @type == :array
        @element || find_element(@type, @identificator)
      end

      def elements
        type = :id
        type = @type unless @type == :array
        find_elements(type, @identificator)
      end
    end
  end
end
