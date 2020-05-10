# frozen_string_literal: true

ENV['MRUBY_CONFIG'] ||= "#{__dir__}/build_config.rb"
mruby_version = ENV['MRUBY_VERSION'] || '2.1.0'
mruby_root = "#{__dir__}/mruby"

ENV['TEST_DIR'] = "#{__dir__}/test"

def verbose?
  verbose == true
end

file :mruby do
  sh 'curl -L --fail --retry 3 --retry-delay 1 -s -o - ' \
     "https://github.com/mruby/mruby/archive/#{mruby_version}.tar.gz " \
     '| tar zxf -'
  mv "mruby-#{mruby_version}", mruby_root, verbose: verbose?
end
Rake::Task[:mruby].invoke unless File.exist?(mruby_root)
load 'mruby/Rakefile'

desc 'clean all'
task :distclean do
  rm_r mruby_root, secure: true, verbose: verbose?
end
