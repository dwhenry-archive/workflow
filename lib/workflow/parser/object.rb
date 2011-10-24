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
        @tree = {}
      end
      
      def to_hash
        @hash = {}
        @tree.each do |key, value|
          if value.respond_to?(:to_hash)
            @hash[key] = value.to_hash
          else
            @hash[key] = value
          end
        end
        @hash
      end
      
      def to_s
        @tree.map do |key, value|
          if value.respond_to?(:to_hash)
            value.to_s
          else
            "#{key} => #{value}"
          end
        end.join("\n")
      end
    end
    
    class AstRoot < Ast
      def start
        @tree[:start] = AstStart.new
      end  
    end
    
    class AstStart < Ast
      def at
        self
      end
      
      def method_missing(mth, *args, &blk)
        if mth.to_s =~ /^(1|)\d(a|p)m$/ 
          @tree[:time] = mth.to_s
          return self
        end
      end
      
      def to_s
        "START at #{@tree[:time]}"
      end
    end
  end
end