require 'calabash-android/abase'

module ScreenElement
  module CalabashEnv
    class BaseElement < Calasbash::ABase

      attr_accessor :element

      def initialize(type, identificator)
        @type = type
        @identificator = identificator
      end

      def visible!(opt = {})
        timeout = opt.fetch(:timeout, 10)
        begin
          wait_for(timeout) { element_exists(element) }
        rescue => exception
          raise ElementNotFoundError,
                "Element with #{@type}: #{@identificator} not found!\n#{exception.message}"
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
          wait_for(timeout) { element_does_not_exist(element)}
        rescue => exception
          raise ElementFoundError,
                "Element with #{@type}: #{@identificator} found!\n#{exception.message}"
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
        touch(element)
      end

      def element
        "* #{@type}:'#{@identificator}'"
      end
    end
  end
end