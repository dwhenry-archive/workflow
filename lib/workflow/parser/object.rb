module Parser
  class Object
    class ObjectParserError < StandardError; end
    
    def parse(string)
      @ast = Builder.new(string).ast
    end
    
    def definition
      @ast.to_hash
    end
    
    def to_s
      @ast.to_s
    end
    
    class Builder
      attr_accessor :ast
      def initialize(string)
        @string = string
        @commands = string.split(' ')
        build
      end
      
      def build
        node = @ast = AstRoot.new
        nodes = [@ast]
        @commands.each do |command|
          begin
            node = node.send(command.downcase, command)
            nodes << node
          rescue ObjectParserError => e
            message ||= e.message
            raise ParserError, "#{@string} => #{message}" if nodes.empty?
            nodes.uniq!
            node = nodes.pop
            retry
          end
        end
      end
    end
    
    class Ast
      def initialize
        @tree = []
      end
      
      def to_hash
        @hash = {}
        @tree.each do |node|
          @hash.merge! node.to_hash
        end
        @hash
      end
      
      def to_s
        @tree.map(&:to_s).join("\n")
      end
      
      def add(node)
        @tree << node
        @tree.last
      end
      protected :add
      
      def method_missing(mth, *args, &blk)
        raise ObjectParserError, "Unknown keyword: #{mth}"
      end
    end
    
    class AstRoot < Ast
      def start(command)
        add AstStart.new
      end  
    end
    
    class AstStart < Ast
      def after(command)
        add AstTime.new
      end
      
      def when(command)
        add AstWhen.new
      end

      def to_hash
        {:start => super}
      end
      
      def to_s
        "START #{@tree.map(&:to_s).join(' ')}"
      end
    end
    
    class AstTime
      DayOfWeek = {'mon' => 'monday', 'tue' => 'tuesday', 'wed' => 'wednesday', 'thu' => 'thursday', 
                   'fri' => 'friday', 'sat' => 'saturday', 'sun' => 'sunday'}
      def initialize
        @details = {}
      end
      
      def to_s
        str = "after #{@details[:time]}"
        str << " " << @details[:dow].titlecase if @details[:dow]
        str
      end

      def to_hash
        {:after => @details}
      end

      def method_missing(mth, *args, &blk)
        case mth.to_s
        when /^(1[012]|\d)(a|p)m$/
          raise ObjectParserError, "Multiple Time Values: '#{@details[:time]}', '#{mth}'" if @details[:time]
          @details[:time] = mth.to_s
        when *DayOfWeek.values
          @details[:dow] = mth.to_s
        when *DayOfWeek.keys
          @details[:dow] = DayOfWeek[mth.to_s]
        else
          raise ObjectParserError, "Invalid Time Option: '#{args[0]}'" if @details[:time]
          raise ObjectParserError, "Invalid Time: '#{args[0]}'"
        end
        return self
      end
    end
    
    class AstWhen
      def initialize
        @details = {}
        @state = :url
      end
      
      def to_hash
        {:when => @details}
      end
      
      def to_s
        "WHEN #{@details[:url]} RETURNS #{@details[:returns]}"
      end
      
      def method_missing(mth, *args, &blk)
        raise ObjectParserError, "Missing keyword 'RETURNS' in 'WHEN <url> RETURNS <status>" if @state == :pending_return
        @details[@state] = mth.to_s
        transition_state
        self
      end
      
      def returns(command)
        raise ObjectParserError, "Missing <url> in 'WHEN <url> RETURNS <status>" unless @state == :pending_return
        transition_state
        self
      end
      
      protected
      def transition_state
        case @state
        when :url
          @state = :pending_return
        when :pending_return
          @state = :returns
        when :returns
          @state = :finished
        end
      end
    end
  end
end