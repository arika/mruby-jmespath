# frozen_string_literal: true

MRuby::Gem::Specification.new('mruby-jmespath') do |spec|
  spec.license = 'Apache-2.0'
  spec.authors = 'akira yamada'
  spec.summary = 'JMESPath for mruby'

  spec.add_dependency 'mruby-fiber'
  spec.add_dependency 'mruby-kernel-ext'
  spec.add_dependency 'mruby-metaprog'
  spec.add_dependency 'mruby-string-ext'
  spec.add_dependency 'mruby-struct'

  spec.add_dependency 'mruby-set'
  spec.add_dependency 'mruby-stringio'
  spec.add_dependency 'mruby-iijson'

  spec.add_test_dependency 'mruby-dir'
  spec.add_test_dependency 'mruby-env'
  spec.add_test_dependency 'mruby-io'
end
