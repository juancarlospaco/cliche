import cliche, std/[strutils, unittest, strformat, math]

proc testTypeBounds(t: typedesc) =
  @[&"--foo={high t}",
    &"--bar={low t}"].getOpt (foo: t(0), bar: t(0))

  doAssert foo == high t
  doAssert bar == low t

suite "Cliche CLI parsing arguments":
  test "parse char":
    @["--foo=z"].getOpt (foo: 'x')
    doAssert foo is char
    doAssert foo == 'z'

  test "parse simple ints":
    @["--foo=1", "--bar=2", "--baz=3"].getOpt (foo: 0, bar: 0i16, baz: 0u64)
    doAssert foo is int
    doAssert foo == 1

    doAssert bar is int16
    doAssert bar == 2

    doAssert baz is uint64
    doAssert baz == 3

  test "parse simple floats":
    @["--foo=4.2", "--bar=9.7"].getOpt (foo: 0f32, bar: 0f64)

    doAssert almostEqual(foo, 4.2)
    doAssert almostEqual(bar, 9.7)

  test "parse big and small numbers":
    testTypeBounds int64
    testTypeBounds uint64
    testTypeBounds float32
    testTypeBounds float64
