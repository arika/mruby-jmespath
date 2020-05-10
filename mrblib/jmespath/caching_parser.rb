module JMESPath
  class CachingParser

    def initialize(options = {})
      @parser = options[:parser] || Parser.new(options)
      cache = {}
      @fiber = Fiber.new do |expression|
        loop do
          cache.clear if cache.size > 1000
          result = cache[expression] = @parser.parse(expression)
          expression = Fiber.yield(result)
        end
      end
    end

    def parse(expression)
      @fiber.resume(expression)
    end

  end
end
