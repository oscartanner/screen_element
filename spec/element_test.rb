require 'screen_element'
require 'pry'

describe 'Element Interface' do
  before(:each) do
    @classes = [ScreenElement::AppiumEnv::Element]
    @number_public_instance_methods = 6
  end

  # after(:each) do
  # end

  describe 'Implemented methods' do
    context 'All Element classes should have the same interface methods' do
      it 'All classes should have the same number of public instance methods (@number_public_instance_methods)' do
        @classes.each do |clazz|
          expect(clazz.instance_methods(false).size)
            .to be(@number_public_instance_methods)
        end
      end
    end
  end
end
