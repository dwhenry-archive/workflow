module Parser
  class RegexParserError < StandardError; end
  
  class RegEx
    ELEMENTS = [:start]
    attr_accessor :definition

    def parse(string)
      expressions = Expression.new(string)
      @definition = {}
      ELEMENTS.each do |element|
        @definition.merge!(expressions.send("#{element}_exp"))
      end
    rescue RegexParserError => e
      raise ParserError, "#{string} => #{e.message}"
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
        after_str = [:time, :dow].map{|field| value[:after][field].try(:titlecase)}.compact.join(' ')
        when_value = value[:when]
        when_str =  (when_value ? " WHEN #{when_value[:url]} RETURNS #{when_value[:returns]}" : '')
        "START after #{after_str}#{when_str}"
      end
    end
  
    class Expression
      DayOfWeek = {'mon' => 'monday', 'tue' => 'tuesday', 'wed' => 'wednesday', 'thu' => 'thursday', 
                   'fri' => 'friday', 'sat' => 'saturday', 'sun' => 'sunday'}
      
      def initialize(string)
        @original_string = string
        @string = string.downcase
      end
      
      def start_exp
        return {} unless @string =~ /^start after/
        when_hash = when_exp
        @string =~ /^start after (.*)$/
        {:start => process_time($1).merge(when_hash)}
      end

      def when_exp
        return {} unless @string =~ /when [^ ]*/
        raise RegexParserError, "Missing <url> in 'WHEN <url> RETURNS <status>" if @string =~ /(when returns [^ ]*)/
        raise RegexParserError, "Missing keyword 'RETURNS' in 'WHEN <url> RETURNS <status>" unless @string =~ /(when [^ ]* returns [^ ]*)/
        match = $1
        @string.gsub!(match, '')
        process_when(match)
      end
      
      def process_when(string)
        string =~ /when ([^ ]*) returns ([^ ]*)/
        {:when => {:url => $1, :returns => $2}}
      end
      
      def process_time(string)
        string =~ /(^| )((1[012]|\d)(a|p)m)($| )/
        time = $2
        raise RegexParserError, "Invalid Time: '#{string}'" unless time
        string.gsub!(time, '')
        raise RegexParserError, "Multiple Time Values: '#{time}', '#{$2}'" if string =~ /(^| )((1[012]|\d)(a|p)m)($| )/

        string =~ /(^| )(#{DayOfWeek.flatten.join('|')})($| )/
        day = $2

        string.gsub!(day, '') if day
        string.gsub!(/  /, ' ')
        string = string.strip
        pos = @string =~ /#{string}/
        raise RegexParserError, "Invalid Time Option: '#{@original_string[pos..pos+string.size-1]}'" unless string == ''
        
        hash = {:time => time}
        hash[:dow] = (DayOfWeek[day] || day) if day
        {:after => hash}
      end
    end
  end
end