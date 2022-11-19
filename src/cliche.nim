## .. image:: https://raw.githubusercontent.com/juancarlospaco/cliche/nim/cliche-banner.jpg
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
              elif element[1].kind == nnkIdent and (element[1].eqIdent"true" or element[1].eqIdent"false"): "bool"
              else: "string"
            )
        result.add '\t'
        result.add element[^1].repr
        result.add '\n'
    result.add prefix
    result.add prefix
    result.add "xdebug\tDebug info for devs\n"
    result.add prefix
    result.add prefix
    result.add "help\t?\t"
    result.add helpMessage


func xdebug(): string =
  result = "nim\t"
  result.add NimVersion
  result.add "\ncpu\t"
  result.add hostCPU
  result.add "\nos\t"
  result.add hostOS
  result.add "\nrelease\t"
  result.add $defined(release)
  result.add "\ndanger\t"
  result.add $defined(danger)
  result.add "\nlto\t"
  result.add $defined(lto)
  result.add "\nstrip\t"
  result.add $defined(strip)


macro unrolledStringVsSymbolComparisonImpl(simbol: typed; value: static[string]): untyped =
  template chainIt(a, b) = (a = nnkInfix.newTree(newIdentNode"and", a, b))
  result = newStmtList()
  result.add nnkInfix.newTree(newIdentNode"==", nnkDotExpr.newTree(simbol, newIdentNode"len"), newLit(value.len))
  var conditionals = newSeqOfCap[NimNode](value.len)
  for i in 0 ..< value.len: conditionals.add nnkInfix.newTree(newIdentNode"==", nnkBracketExpr.newTree(simbol, newLit i), newLit value[i])
  for conditional in conditionals: chainIt result, conditional


macro getOpt*(source: seq[string]; variables: untyped; helpMessage: static[string] = "";
              sepa: static[char] = '='; prefix: static[char] = '-'; useEnvVars: static[bool] = false) =
  doAssert variables.len > 0, "Argument must not be empty"
  doAssert variables.kind == nnkTupleConstr, "Argument must be 1 static named tuple"
  for n in variables: doAssert n.kind == nnkExprColonExpr, "Argument must be 1 static named tuple"
  var
    newFor = newTree(nnkForStmt)
    forBody = newStmtList()
    declarations = newStmtList()
    name, value: NimNode
  let
    apiExplained: string = explainHelp(variables, helpMessage, prefix, sepa)
    xdebugInfos:  string = xdebug()
  result = newStmtList()
  # for v in source:
  newFor.add ident"v"
  newFor.add source
  #   var sepPos: int
  #   var k, b: string
  forBody.add nnkVarSection.newTree(
    nnkIdentDefs.newTree(newIdentNode"sepPos", newIdentNode("int"), newEmptyNode()),
    nnkIdentDefs.newTree(newIdentNode"key", newIdentNode"val", newIdentNode"string", newEmptyNode())
  )

  forBody.add(quote do:
    if not(v.len > 3) or v[0] != char(`prefix`) or v[1] != char(`prefix`): continue
    if v.len == 6 and v[2] == 'h' and v[3] == 'e' and v[4] == 'l' and v[5] == 'p': quit(`apiExplained`, 0)
    if v.len == 8 and v[2] == 'x' and v[3] == 'd' and v[4] == 'e' and v[5] == 'b' and v[6] == 'u' and v[7] == 'g': quit(`xdebugInfos`, 0)
    sepPos = v.len - 1
    for x in 2 ..< v.len:
      if v[x] == char(`sepa`):
        sepPos = x
        break
    key = v[2 .. sepPos - 1]
    val = v[sepPos + 1 .. v.len - 1]
  )
  # Can be replaced with this for `experimental:views` ?.
  # k = v.toOpenArray 2, sepPos - 1
  # b = v.toOpenArray sepPos + 1, v.len - 1
  for key_value in variables:
    name = key_value[0]
    doAssert validIdentifier name.strVal, "Names must be valid identifiers"

    value = key_value[1]
    doAssert value.kind != nnkNilLit, "Default value must not be static Nil"

    if useEnvVars:
      forBody.add(quote do:
        val = getEnv("NIM_" & key.toUpperAscii, val)
      )

    declarations.add(  # var name = defaultValue
      nnkVarSection.newTree(nnkIdentDefs.newTree(name, newEmptyNode(), value))
    )  # Make all variable declarations before the for loop itself.

    let literalParam = name.strVal
    forBody.add(quote do:
      if unrolledStringVsSymbolComparisonImpl(key, `literalParam`):
        `name` =
          when `value` is Positive:        Positive(val.parseInt)
          elif `value` is Natural:         Natural(val.parseInt)
          elif `value` is BiggestUInt:     BiggestUInt(val.parseUint)
          elif `value` is BiggestInt:      BiggestInt(val.parseInt)
          elif `value` is BiggestFloat:    BiggestFloat(val.parseFloat)
          elif `value` is byte:            byte(val.parseInt)
          elif `value` is char:            char(val[0])
          elif `value` is cfloat:          cfloat(val.parseFloat)
          elif `value` is float32:         float32(val.parseFloat)
          elif `value` is float64:         float64(val.parseFloat)
          elif `value` is float:           float(val.parseFloat)
          elif `value` is cint:            cint(val.parseInt)
          elif `value` is SomeSignedInt:   typeof(`value`)(val.parseInt)
          elif `value` is SomeUnsignedInt: typeof(`value`)(val.parseUInt)
          elif `value` is bool:            parseBool(val)
          elif `value` is enum:            parseEnum[typeof(`value`)](val)
          elif `value` is cstring:         cstring(val)
          else:                            val
    )
  newFor.add forBody
  result.add declarations
  result.add newFor


runnableExamples:
  import std/strutils
  # Use https://nim-lang.github.io/Nim/os.html#commandLineParams
  block:
    type Food = enum PIZZA, TACO  # Enum from CLI.
    # let real = commandLineParams()
    let fake = @["--a=1", "--v_1=9.9", "--v2=1", "--v3=2", "--v4=X", "--v5=t", "--v6=z", "--v7=true", "--food=PIZZA", "--help"]
    fake.getOpt (a: int.high, v_1: 3.14, v2: 9'u64, v3: -9'i64, v4: "a", v5: '4', v6: cstring"b", v7: false, missing: 42, food: TACO)
    doAssert a == 1
    doAssert v_1 == 9.9
    doAssert v2 == 1'u64
    doAssert v3 == 2'i64
    doAssert v4 == "X"
    doAssert v5 == 't'
    doAssert v6 == cstring"z"
    doAssert v7 == true
    doAssert missing == 42 # missing is not in fake, fallback to default value 42.
    doAssert food is Food and food == PIZZA  # food is Food.PIZZA
  block:
    let fake = @["--a=false", "--b=5", "--c=1", "--d=2.0", "--e=3", "--f=128"]
    fake.getOpt (a: true, b: 9.Positive, c: 5.cint, d: 0.0.float32, e: 0.Natural, f: 255.byte)
    doAssert a == false
    doAssert b == 5.Positive
    doAssert c == 1.cint
    doAssert d == 2.0.float32
    doAssert e == 3.Natural
    doAssert f == 128.byte

## * Auto-Generated `--help` (Can be parsed as TSV):
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
