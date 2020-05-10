module JMESPath
  # @api private
  module Nodes
    class Node
      def visit(value)
      end

      def hash_like?(value)
        Hash === value || Struct === value
      end

      def optimize
        self
      end

      def chains_with?(other)
        false
      end
    end
  end
end
