json_files = []
%w[compliance legacy].map do |d|
  dir = "#{ENV['TEST_DIR']}/#{d}"
  Dir.foreach(dir) do |f|
    f = "#{dir}/#{f}"
    json_files << f if File.file?(f)
  end
end

json_files.each do |path|
  GC.start # XXX: to avoid "pointer being freed was not allocated" error on test

  extname = File.extname(path)
  test_file = File.basename(path)[0..-(extname.size + 1)]
  next if test_file == 'benchmarks'
  next if ENV['TEST_FILE'] && ENV['TEST_FILE'] != test_file

  JMESPath.load_json(path).each do |scenario|
    t = "Compliance: #{test_file}: Given #{scenario['given'].to_json}"
    scenario['cases'].each do |test_case|
      if test_case['error']
        assert("#{t}: the expression #{test_case['expression'].inspect} raises a #{test_case['error']} error") do
          error_class =
            case test_case['error']
            when 'runtime' then JMESPath::Errors::RuntimeError
            when 'syntax' then JMESPath::Errors::SyntaxError
            when 'invalid-type' then JMESPath::Errors::InvalidTypeError
            when 'invalid-value' then JMESPath::Errors::InvalidValueError
            when 'invalid-arity' then JMESPath::Errors::InvalidArityError
            when 'unknown-function' then JMESPath::Errors::UnknownFunctionError
            else raise "unhandled error type #{test_case['error']}"
            end
          assert_raise(error_class) do
            JMESPath.search(test_case['expression'], scenario['given'])
          end
        end
      else
        assert("#{t}: searching #{test_case['expression'].inspect} returns #{test_case['result'].to_json}") do
          result = JMESPath.search(test_case['expression'], scenario['given'])
          assert_equal(test_case['result'], result)
        end
      end
    end
  end
end
