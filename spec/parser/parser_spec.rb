require 'spec_helper'
  
shared_examples_for "A parser object" do
  context 'Start Criteria' do
    it 'at a given time' do
      subject.parse('START after 7pm')
      subject.definition.should == {:start => {:after => {:time => '7pm'}}}
      subject.to_s.should == 'START after 7pm'
    end
    
    it 'at a given time on a given day of week' do
      subject.parse('START after 7pm Monday')
      subject.definition.should == {:start => {:after => {:time => '7pm', :dow => 'monday'}}}
      subject.to_s.should == 'START after 7pm Monday'
    end
    
    context 'check the different valid day options' do
      before do
        subject.parse('START after 7pm Monday')
        @definition = subject.definition
      end
      
      it 'in reverse order' do
        subject.parse('START after Monday 7pm')
        subject.definition.should == @definition
      end

      it 'with short day of week name' do
        subject.parse('START after 7pm Mon')
        subject.definition.should == @definition
      end
    end
    
    context 'invalid time options' do
      it 'time value of 23pm' do
        lambda { subject.parse('START after 23pm') }.should raise_error ParserError, "START after 23pm => Invalid Time: '23pm'"
      end

      it 'time value of 13pm' do
        lambda { subject.parse('START after 13pm') }.should raise_error ParserError, "START after 13pm => Invalid Time: '13pm'"
      end

      it 'time value is 24Hr' do
        lambda { subject.parse('START after 12') }.should raise_error ParserError, "START after 12 => Invalid Time: '12'"
      end

      it 'time value is negative' do
        lambda { subject.parse('START after -12pm') }.should raise_error ParserError, "START after -12pm => Invalid Time: '-12pm'"
      end
      
      it 'invalid day of week' do
        lambda { subject.parse('START after 12pm MMM') }.should raise_error ParserError, "START after 12pm MMM => Invalid Time Option: 'MMM'"
      end

      it 'multiple times' do
        lambda { subject.parse('START after 12pm 7pm') }.should raise_error ParserError, "START after 12pm 7pm => Multiple Time Values: '12pm', '7pm'"
      end
    end
    
    context 'WHEN url RETURNS value' do
      let(:time_string) { 'START after 12pm' }
      let(:when_string) { 'WHEN http://fake.web/test RETURNS ready' }
      
      it 'sets the url details on the definition' do
        subject.parse("#{time_string} #{when_string}")
        subject.definition.should == {:start => {:after => {:time => '12pm'},
                                              :when => {:url => 'http://fake.web/test', :returns => 'ready'}}}
      end
      
      it 'sets converts back to a string' do
        subject.parse("#{time_string} #{when_string}")
        subject.to_s.should == "#{time_string} #{when_string}"
      end
      
      it 'must have the returns value for the when url' do
        string = "#{time_string} WHEN http://fake.web/test ready"
        expect { subject.parse(string) }.to raise_error ParserError, "#{string} => Missing keyword 'RETURNS' in 'WHEN <url> RETURNS <status>"
      end

      it 'must have a url to check' do
        string = "#{time_string} WHEN RETURNS ready"
        expect { subject.parse(string) }.to raise_error ParserError, "#{string} => Missing <url> in 'WHEN <url> RETURNS <status>"
      end
    end
  end
end

describe Parser::Object do
  it_should_behave_like "A parser object"
end

describe Parser::RegEx do
  it_should_behave_like "A parser object"
end

