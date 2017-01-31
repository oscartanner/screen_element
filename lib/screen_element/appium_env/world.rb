require 'appium_lib'

module ScreenElement
  module AppiumEnv
    class World
      class << self
        attr_accessor :caps_path, :screenshot_path
      end

      def self.caps
        Appium.load_appium_txt file: caps_path, verbose: true
      end

      def self.take_screenshot(opt = {})
        path = opt.fetch(:path, screenshot_path)
        
        file_name = opt.fetch(:file_name, "screenshot_#{Time.now.strftime('%Y%m%d%H%M%S')}.png")
        raise 'Screenshot path is null!! Please set option[:path].' if path.nil?
        $driver.screenshot(
          File.join(path, file_name,
                    )
        )
      end

      def self.reinstall_app
        $driver.remove_app ScreenElement::AppiumEnv::World.caps[:caps][:appPackage]
        $driver.start_driver # TODO: ver se launsh_app funciona
      end
    end
  end
end
