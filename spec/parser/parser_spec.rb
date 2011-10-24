require 'spec_helper'
  
shared_examples_for "A parser object" do
  context 'Start Criteria' do
    it 'at a given time' do
      subject.parse('START at 7pm')
      subject.definition.should == {:start => {:time => '7pm'}}
      subject.to_s.should == 'START at 7pm'
    end
  end
end

describe Parser::Object do
  it_should_behave_like "A parser object"
end

describe Parser::RegEx do
  it_should_behave_like "A parser object"
end

