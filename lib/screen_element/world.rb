require 'appium_lib'

module ScreenElement
  class World
    class << self
      attr_accessor :caps_file, :screenshot_path, :driver
    end

    def self.caps(opt = {})
      file = opt.fetch(:file, caps_file)
      raise 'File is null!! Please set option[:file].' if file.nil?
      Appium.load_appium_txt file: file, verbose: true
    end

    def self.take_screenshot(opt = {})
      path = opt.fetch(:path, screenshot_path)

      file_name =
        opt.fetch(:file_name,
                  "screenshot_#{Time.now.strftime('%Y%m%d%H%M%S')}.png")
      raise 'Path is null!! Please set option[:path].' if path.nil?

      driver.screenshot(File.join(path, file_name))
      File.join(path, file_name)
    end

    def self.remove_app
      app = if caps[:caps][:platformName].casecmp('ios').zero?
              caps[:caps][:bundleId]
            else
              caps[:caps][:appPackage]
            end
      driver.remove_app app
    end

    def self.reinstall_app
      remove_app
      driver.launch_app
    end

    def self.promote_appium_methods(opt = {})
      @driver = Appium::Driver.new(caps(opt))
      Appium.promote_appium_methods self
    end

    def self.start_driver
      driver.start_driver
    end

    def self.driver_quit
      driver.driver_quit
    end

    def self.launch_app
      driver.launch_app
    end

    def self.close_app
      driver.close_app
    end

    def self.navigate_back
      driver.back
    end

    def self.source
      driver.get_source
    end
  end
end
