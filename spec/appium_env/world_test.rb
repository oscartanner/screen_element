require 'screen_element'

describe ScreenElement::AppiumEnv::World do
  # before(:each) do
  # end

  # after(:each) do
  # end

  describe 'Methods' do
    context 'Take Screenshot Method' do
      it 'If path is null, an exception should be thrown' do
        expect { ScreenElement::AppiumEnv::World.take_screenshot }
          .to raise_exception 'Screenshot path is null!! Please set option[:path].'
      end
    end
  end
end
