# mruby-jmespath

JMESPath for mruby.

This is a port of [jmespath.rb](https://github.com/jmespath/jmespath.rb) 1.4.0.

## Modifications from original jmespath.rb

* jmespath.rb: disable Pathname support
* jmespath/caching_parser.rb: don't use Mutex
* jmespath/lexer.rb: remove `requires_wrapping?`
* jmespath/lexer.rb: don't use `begin ... end while`
* jmespath/nodes/subexpression.rb: define `Pipe` (and remove jmespath/nodes/pipe.rb)
* jmespath/parser.rb: don't use Regexp
* jmespath/*: remove `require`
* jmespath/*: use `JSON.parse`
* spec/*_spec.rb: rewrite by mruby's `assert`

## Note

Currentry test/compliance.rb calls `GC.start` for each assertion to avoid
"pointer being freed was not allocated" error.
(`GC.start` or `MRB_GC_TURN_OFF_GENERATIONAL` can avoid the error.)
