module ScreenElement
  module AppiumEnv
    class BaseElement < World
      include OCRHelperModule

      attr_accessor :element

      def initialize(type, identificator, opt = {})
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
          type = opt.fetch(:array_type, :id) if type == :array
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
        element.send_keys text
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
        @element || find_element(@type, @identificator)
      end

      def elements
        find_elements(@type, @identificator)
      end
    end
  end
end
