import std/[macros, os, strutils], cliche
expandMacros:
  commandLineParams().getOpt (foo: 'x')
doAssert foo == 'z'
