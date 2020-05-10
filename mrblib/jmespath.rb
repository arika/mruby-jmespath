module JMESPath
  class << self
    # @param [String] expression A valid
    #   [JMESPath](https://github.com/boto/jmespath) expression.
    # @param [Hash] data
    # @return [Mixed,nil] Returns the matched values. Returns `nil` if the
    #   expression does not resolve inside `data`.
    def search(expression, data, runtime_options = {})
      data = case data
        when Hash, Struct then data # check for most common case first
        # when Pathname then load_json(data)
        when IO, StringIO then JSON.load(data.read)
        else data
        end
      Runtime.new(runtime_options).search(expression, data)
    end

    # @api private
    def load_json(path)
      JSON.parse(File.open(path, 'r') { |f| f.read })
    end
  end
end
