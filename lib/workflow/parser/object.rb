module Parser
  class Object
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
        @commands = string.downcase.split(' ')
        build
      end
      
      def build
        node = @ast = AstRoot.new
        @commands.each do |command|
          node = node.send(command)
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
    end
    
    class AstRoot < Ast
      def start
        add AstStart.new
      end  
    end
    
    class AstStart < Ast
      def at
        add AstTime.new
      end

      def to_hash
        {:start => super}
      end
      
      def to_s
        "START #{@tree.map(&:to_s).join(' ')}"
      end
    end
    
    class AstTime
      def to_s
        "at #{@time}"
      end
      
      def to_hash
        {:time => @time}
      end
      
      def method_missing(mth, *args, &blk)
        if mth.to_s =~ /^(1|)\d(a|p)m$/ 
          @time = mth.to_s
          return self
        end
      end
    end
  end
end