require 'screen_element'

describe ScreenElement::AppiumEnv::World do
  # before(:each) do
  # end

  # after(:each) do
  # end

  describe 'Methods' do
    context 'Take Screenshot Method' do
      exception_message = 'Screenshot path is null!! Please set option[:path].'
      it 'If path is null, an exception should be thrown' do
        expect { ScreenElement::AppiumEnv::World.take_screenshot }
          .to raise_exception exception_message
      end

      it 'Screenshot path can be set as an class variable' do
        ScreenElement::AppiumEnv::World.screenshot_path = 'test'
        expect { ScreenElement::AppiumEnv::World.take_screenshot }
          .not_to raise_exception exception_message
      end

      it 'Screenshot path can be set as an optional parameter' do
        expect { ScreenElement::AppiumEnv::World.take_screenshot(path: 'test') }
          .not_to raise_exception exception_message
      end
    end
  end
end
