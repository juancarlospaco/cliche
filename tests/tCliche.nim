import cliche, std/[strutils, unittest, strformat]

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

  test "parse big and small ints":
    @[&"--foo={high int64}",
      &"--bar={low int64}"].getOpt (foo: 0i64, bar: 0i64)

    doAssert foo == high int64
    doAssert bar == low int64

    @[&"--baz={high uint64}",
      &"--foobar={low uint64}"].getOpt (baz: 0u64, foobar: 0u64)

    doAssert foo == high int64
    doAssert bar == low int64
