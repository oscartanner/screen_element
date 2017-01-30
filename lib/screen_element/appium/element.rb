module ScreenElement
  module Appium
    class Element < World
      def initialize(type, identificator)
        if type == :desc
          @type = :xpath
          @identificator = "//*[@content-desc='#{identificator}']"
        else
          @type = type
          @identificator = identificator
        end
      end

      def visible!(opt = {})
        timeout = opt.fetch(:timeout, 10)
        begin
          wait_true(timeout) { element.displayed? }
        rescue => e
          raise ElementNotFoundError,
            "Element with #{@type}: '#{@identificator}' not found!\n#{e.message}"
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

      # TODO: See if would be nice to implement these methods with method missing
      # to avoid creating all these accessor methods for element attributes
      def text
        element.text
      end

      private

      def element
        find_element(@type, @identificator)
      end
    end
  end
end
