import std/macros, cligen
func x(foo = 'x') = doAssert foo == 'z'
expandMacros:
  dispatch x
