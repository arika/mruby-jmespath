t = 'JMESPath.search: indifferent access'

assert("#{t}: treats hashes indifferently with symbols/strings") do
  data = { foo: { bar: { yuck: 'abc' } } }
  assert_equal('abc', JMESPath.search('foo.bar.yuck', data))
end

assert("#{t}: supports searching over strucures") do
  data = Struct.new(:foo).new(
    Struct.new(:bar).new(
      Struct.new(:yuck).new('abc')
    )
  )
  assert_equal('abc', JMESPath.search('foo.bar.yuck', data))
end

assert("#{t}: does not raise an error when accessing non-valid struct members") do
  data = Struct.new(:foo).new(
    Struct.new(:bar).new(
      Struct.new(:yuck).new('abc')
    )
  )
  assert_nil(JMESPath.search('foo.baz.yuck', data))
end
