require 'appium_lib'

module ScreenElement
  module AppiumEnv
    class World
      class << self
        attr_accessor :caps_path, :screenshot_path
      end

      def self.caps(opt = {})
        path = opt.fetch(:path, caps_path)
        raise 'Path is null!! Please set option[:path].' if path.nil?
        Appium.load_appium_txt file: path, verbose: true
      end

      def self.take_screenshot(opt = {})
        path = opt.fetch(:path, screenshot_path)

        file_name =
          opt.fetch(:file_name,
                    "screenshot_#{Time.now.strftime('%Y%m%d%H%M%S')}.png")
        raise 'Path is null!! Please set option[:path].' if path.nil?

        $driver.screenshot(File.join(path, file_name))
      end

      def self.reinstall_app
        $driver.remove_app ScreenElement::AppiumEnv::World.caps[:caps][:appPackage]
        $driver.start_driver # TODO: ver se launsh_app funciona
      end

      def self.promote_appium_methods
        Appium::Driver.new(ScreenElement::AppiumEnv::World.caps)
        Appium.promote_appium_methods ScreenElement::AppiumEnv::World
      end

      def start_driver
        $driver.start_driver
      end

      def driver_quit
        $driver.driver_quit
      end

      def launch_app
        $driver.launch_app
      end

      def close_app
        $driver.close_app
      end
    end
  end
end