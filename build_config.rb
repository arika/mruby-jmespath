# frozen_string_literal: true

MRuby::Build.new do |conf|
  toolchain :gcc

  conf.gem core: 'mruby-bin-mirb'
  conf.gem core: 'mruby-bin-mruby'
  conf.gem __dir__

  conf.enable_debug
  conf.enable_test
  conf.cc.defines += [
    'MRB_UTF8_STRING', # for 'test/compliance/identifiers.json'
    # 'MRB_GC_TURN_OFF_GENERATIONAL', # XXX: to avoid "pointer being freed was not allocated" error on test
  ]
end
