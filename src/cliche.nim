import std/[macros, strutils]

func explainHelp(params: NimNode; helpMessage: string; prefix, sepa: char): string =
    result = "key\ttype\tdefault\n"
    for element in params:
        result.add prefix
        result.add prefix
        result.add element[0].repr
        result.add sepa
        result.add '\t'
        if element[1].len > 1 and element[1].kind == nnkDotExpr:
            result.add element[1][0].repr
        else:
            result.add(
              case element[1].kind
              of nnkCharLit:                    "char"
              of nnkIntLit .. nnkInt64Lit:      "int"
              of nnkUintLit .. nnkUInt64Lit:    "uint"
              of nnkFloatLit .. nnkFloat128Lit: "float"
              else: "string"
            )
        result.add '\t'
        result.add element[^1].repr
        result.add '\n'
    result.add prefix
    result.add prefix
    result.add "help\t?\t"
    result.add helpMessage

macro getOpt*(source: seq[string]; variables: untyped; helpMessage: static[string] = "";
              sepa: static[char] = '='; prefix: static[char] = '-';) =
  doAssert variables.len > 0, "Argument must not be empty"
  doAssert variables.kind == nnkTupleConstr, "Argument must be 1 static named tuple"
  for n in variables: doAssert n.kind == nnkExprColonExpr, "Argument must be 1 static named tuple"
  var
    newFor = newTree(nnkForStmt)
    forBody = newStmtList()
    declarations = newStmtList()
    name, value: NimNode
  result = newStmtList()
  newFor.add ident"v"
  newFor.add source  # for v in source:
  forBody.add(       #   let k_v = split(v, '=', 1)
    nnkLetSection.newTree(nnkIdentDefs.newTree(newIdentNode"k_v", newEmptyNode(),
      nnkCall.newTree(newIdentNode"split", newIdentNode"v", newLit(sepa), newLit(1))
    ))  # Very likely it never needs >2 items in the seq[string] of k_v anyway.
  )

  forBody.add(  # if k_v[0][0] != '-' or k_v[0][1] != '-': continue
    nnkIfStmt.newTree(nnkElifBranch.newTree(nnkInfix.newTree(
        newIdentNode"or",
        nnkInfix.newTree(newIdentNode"!=",
        nnkBracketExpr.newTree(nnkBracketExpr.newTree(newIdentNode"k_v", newLit(0)), newLit(0)),
        newLit('-')
        ),
        nnkInfix.newTree(
          newIdentNode"!=",
          nnkBracketExpr.newTree(nnkBracketExpr.newTree(newIdentNode"k_v", newLit(0)), newLit(1)),
          newLit('-')
        )
      ),
      nnkStmtList.newTree(nnkContinueStmt.newTree(newEmptyNode()))
    )
  )

  )
  forBody.add(  # let k = k_v[0][2..^1]
    nnkLetSection.newTree(nnkIdentDefs.newTree(newIdentNode"k", newEmptyNode(),
      nnkBracketExpr.newTree(nnkBracketExpr.newTree(newIdentNode"k_v", newLit(0)),
        nnkInfix.newTree(newIdentNode"..^", newLit(2), newLit(1))
      )         # First 2 char are '-' if it reaches here.
    )
  ))

  let apiExplained: string = explainHelp(variables, helpMessage, prefix, sepa)

  forBody.add(quote do:
    if k == "help":
      quit(`apiExplained`, 0)
  )

  # forBody.add(
  #   nnkIfStmt.newTree(nnkElifBranch.newTree(nnkInfix.newTree(newIdentNode"!=",
  #     nnkCall.newTree(newIdentNode"len", newIdentNode"k"), newLit(2)),
  #     nnkStmtList.newTree(nnkContinueStmt.newTree(newEmptyNode())))
  #   )
  # )

  for key_value in variables:
    for item in key_value:
      if item.kind == nnkIdent:
        for c in item.strVal:
          doAssert c in {'a'..'z', '0'..'9', '_'}, "Name must be ASCII Lowercase"
        name = item
      else:
        doAssert item.kind != nnkNilLit, "Default value must not be static Nil"
        value = item
        declarations.add(  # var name = defaultValue
          nnkVarSection.newTree(nnkIdentDefs.newTree(name, newEmptyNode(), value))
        )  # Make all variable declarations before the for loop itself.
        let literalParam = name.strVal  # --key

        forBody.add(quote do:
          if k == `literalParam`:
            `name` = (
              when `value` is float32:  (proc (c: string): float32 = c.parseInt.float32)
              elif `value` is float:    parseFloat
              elif `value` is int8:     (proc (c: string):  int8 = c.parseInt.int8)
              elif `value` is int16:    (proc (c: string): int16 = c.parseInt.int16)
              elif `value` is int32:    (proc (c: string): int32 = c.parseInt.int32)
              elif `value` is int64:    (proc (c: string): int64 = c.parseInt.int64)
              elif `value` is int:      parseInt
              elif `value` is uint8:    (proc (c: string):  uint8 = c.parseInt.uint8)
              elif `value` is uint16:   (proc (c: string): uint16 = c.parseInt.uint16)
              elif `value` is uint32:   (proc (c: string): uint32 = c.parseInt.uint32)
              elif `value` is uint64:   (proc (c: string): uint64 = c.parseInt.uint64)
              elif `value` is byte:     (proc (c: string): byte = c.parseInt.byte)
              elif `value` is Positive: (proc (c: string): Positive = c.parseInt.Positive)
              elif `value` is Natural:  (proc (c: string): Natural = c.parseInt.Natural)
              elif `value` is char:     (proc (c: string): char = c[0])
              elif `value` is uint:     parseUint
              elif `value` is BiggestInt:  parseBiggestInt
              elif `value` is BiggestUint: parseBiggestUint
              elif `value` is cstring:  cstring
              else:                     strip
            )(k_v[1])
        )
  newFor.add forBody
  result.add declarations
  result.add newFor


runnableExamples:
  import std/strutils
  # Use https://nim-lang.github.io/Nim/os.html#commandLineParams
  # let real = commandLineParams()
  let fake = @["--a=1", "--v_1=9.9", "--v2=1", "--v3=2", "--v4=X", "--v5=t", "--v6=z", "--help"]
  fake.getOpt (a: int.high, v_1: 3.14, v2: 9'u64, v3: -9'i64, v4: "a", v5: '4', v6: cstring"b", missing: 42)
  doAssert a == 1
  doAssert v_1 == 9.9
  doAssert v2 == 1'u64
  doAssert v3 == 2'i64
  doAssert v4 == "X"
  doAssert v5 == 't'
  doAssert v6 == cstring"z"
  doAssert missing == 42  ## missing is not in fake, fallback to default value 42.

## * Auto-Generated `--help`:
##
## .. code-block:: nim
##   $ example --help
##   key     type    default
##   --a=    int     int.high
##   --v_1=  float   3.14
##   --v2=   uint    9'u64
##   --v3=   int     -9'i64
##   --v4=   string  "a"
##   --v5=   char    '4'
##   --v6=   string  cstring"b"
##   --missing=      int     42
##   --help  ?       Some Help Message Here!
