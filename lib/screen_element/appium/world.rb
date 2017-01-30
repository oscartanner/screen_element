module Appium
  class AppiumWorld
    # Until now, there is not a difference in the caps methods that justify
    # specific implementation
    def self.root_path
      File.join(File.dirname(__FILE__), '..')
    end

    def self.caps_path
      caps_path = File.join(root_path, 'lib',
                            'caps', ENV['PLATFORM'].downcase)
      raise 'Specify a CAPS_FILE in cucumber.yml' if ENV['CAPS_FILE'].nil?
      File.join(caps_path, ENV['CAPS_FILE'])
    end

    def self.caps
      Appium.load_appium_txt file: caps_path, verbose: true
    end
  end
end
