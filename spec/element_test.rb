require 'screen_element'

describe 'Element Interface' do
  before(:each) do
    @classes = [ScreenElement::AppiumEnv::Element]
    @interface_methods = [:text, :visible!, :visible?, :not_visible!,
                          :not_visible?, :touch, :drag, :swipe, :enter]
  end

  # after(:each) do
  # end

  describe 'Implemented methods' do
    context 'All Element classes should have the same interface methods' do
      it 'The instance methods should be equal to @interface_methods' do
        @classes.each do |clazz|
          expect(clazz.instance_methods(false).sort)
            .to eq(@interface_methods.sort)
        end
      end
    end
  end
end
