require 'screen_element'
include ScreenElement::AppiumEnv

describe World do
  # before(:each) do
  # end

  # after(:each) do
  # end

  describe 'Methods' do
    context 'take_screenshot' do
      exception_message = 'Path is null!! Please set option[:path].'
      it 'If path is null, an exception should be thrown' do
        expect { World.take_screenshot }
          .to raise_exception exception_message
      end

      it 'Path can be set as an class variable' do
        World.screenshot_path = 'test'
        expect { World.take_screenshot }
          .not_to raise_exception exception_message
      end

      it 'Path can be set as an optional parameter' do
        expect { World.take_screenshot(path: 'test') }
          .not_to raise_exception exception_message
      end
    end

    context 'caps' do
      exception_message = 'Path is null!! Please set option[:path].'
      caps_path = File.join(File.dirname(__FILE__),
                            '..', 'resources', 'caps.txt')
      it 'If path is null, an exception should be thrown' do
        expect { World.caps }
          .to raise_exception exception_message
      end

      it 'Path can be set as an class variable' do
        World.caps_path = caps_path
        expect { World.caps }
          .not_to raise_exception
      end

      it 'Path can be set as an optional parameter' do
        expect { World.caps(path: caps_path) }
          .not_to raise_exception
      end
    end
  end
end
