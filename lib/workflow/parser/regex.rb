module Parser
  class RegEx
    ELEMENTS = [:start]
    attr_accessor :definition

    def parse(string)
      expressions = Expression.new(string)
      @definition = {}
      ELEMENTS.each do |element|
        @definition.merge!(expressions.send("#{element}_exp"))
      end
    end
    
    def to_s
      ToString.new(@definition).value
    end
    
    class ToString
      attr_accessor :value
      def initialize(definition)
        @value = definition.map do |key, value|
          send(key, value)
        end.join("\n")
      end
      
      def start(value)
        "START at #{value[:time]}"
      end
    end
  
    class Expression
      
      def initialize(string)
        @string = string.downcase
      end
      
      def start_exp
        return {:start => {:time => $1}} if @string =~ /^start at (.*)$/
        {}
      end
    end
  end
end