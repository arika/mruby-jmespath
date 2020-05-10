t = 'JMESPath.search'

assert("#{t}: searches data") do
  expression = 'foo.bar'
  data = { 'foo' => { 'bar' => 'value' } }
  assert_equal('value', JMESPath.search(expression, data))
end

assert("#{t}: accepts data as a Pathname") do
  skip unless Object.const_defined?(:Pathname)

  file_path = File.join(ENV['TEST_DIR'], 'fixtures', 'sample.json')
  file_path = Pathname.new(file_path)
  assert_equal([1, 2, 3], JMESPath.search('foo.*.baz', file_path))
end

assert("#{t}: accepts data as an IO object") do
  file_path = File.join(ENV['TEST_DIR'], 'fixtures', 'sample.json')
  File.open(file_path, 'r') do |file|
    assert_equal([1, 2, 3], JMESPath.search('foo.*.baz', file))
  end
end

assert("#{t}: accepts data as an Struct") do
  data = Struct.new(:foo).new(Struct.new(:bar).new('baz'))
  assert_equal('baz', JMESPath.search('foo.bar', data))
end

assert("#{t}: supports bare JSON literals") do
  # this is problematic in older Ruby versions that ship with
  # older versions of the json gem. This will only work
  # with version 1.8.1+ of the json gem.
  assert_equal(true, JMESPath.search('`1` < `2`', {}))
end

assert("#{t}: boolean comparison: supports floating point numbers") do
  assert_true(JMESPath.search('`1.0` == `1.0`', {}))
  assert_true(JMESPath.search('`2.0` != `1.0`', {}))
  assert_true(JMESPath.search('`2.0` > `1.0`', {}))
  assert_true(JMESPath.search('`1.0` < `2.0`', {}))
  assert_true(JMESPath.search('`2.0` >= `1.0`', {}))
  assert_true(JMESPath.search('`1.0` <= `2.0`', {}))
  assert_true(JMESPath.search('`1.0` <= `1.0`', {}))
  assert_true(JMESPath.search('`1.0` >= `1.0`', {}))

  assert_false(JMESPath.search('`2.0` == `1.0`', {}))
  assert_false(JMESPath.search('`1.0` != `1.0`', {}))
  assert_false(JMESPath.search('`1.0` > `1.0`', {}))
  assert_false(JMESPath.search('`2.0` < `2.0`', {}))
  assert_false(JMESPath.search('`1.0` >= `2.0`', {}))
  assert_false(JMESPath.search('`2.0` <= `1.0`', {}))
end
