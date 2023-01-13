# CLIche

- AutoMagic CLI argument parsing is so Cliché.

![](https://raw.githubusercontent.com/juancarlospaco/cliche/nim/cliche.jpg "Image is so Cliché")


# Examples

```nim
import cliche
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
```

* Auto-Generated `--help` (Can be parsed as TSV)

```console
$ example --help
 key     type    default
 --a=    int     int.high
 --v_1=  float   3.14
 --v2=   uint    9'u64
 --v3=   int     -9'i64
 --v4=   string  "a"
 --v5=   char    '4'
 --v6=   string  cstring"b"
 --missing=      int     42
 --help  ?       Some Help Message Here!

$
```


# Cligen Vs Cliche

Imagine you just need `foo` to be `'z'`, with default to `'x'`.

Lets use Cligen (I dont really need a `func` but Cligen API needs it):

```nim
import std/macros, cligen
func x(foo = 'x') = doAssert foo == 'z'
expandMacros:
  dispatch x
```

Expands to:

```nim

proc cligenScope(cf`gensym2: ClCfg) =
  case cf`gensym2.sigPIPE
  of spRaise:
    discard
  of spPass:
    SIGPIPE_pass()
  of spIsOk:
    SIGPIPE_isOk()
  if (
    not (cast[pointer](cgVarSeqStrNil) == cgVarSeqStrNil)):
  proc dispatchx(cmdline: seq[string] = mergeParams(@["x"]); usage = clUse;
                 prefix = ""; parseOnly = false; skipHelp = false; noHdr = false) =
    {.push, hint[XDeclaredButNotUsed]: false.}
    var ap: ArgcvtParams
    ap.val4req = cf`gensym2.hTabVal4req
    let shortH`gensym4 = "h"
    var allParams: seq[string] = if (
      0 < len(cf`gensym2.helpSyntax)): @["help", "help-syntax"] else: @["help"]
    var crbt: CritBitTree[string]
    incl(crbt, optionNormalize("help", "_-"), "help")
    if (
      0 < len(cf`gensym2.helpSyntax)):
      incl(crbt, optionNormalize("help-syntax", "_-"), "help-syntax")
    var mand: seq[string]
    var tab: TextTab = @[]
    let helpHelpRow`gensym4 = @["-" & shortH`gensym4 & ", --help", "", "",
                                ("help", "print this cligen-erated help")[1]]
    if skipHelp:
      if
        not (shortH`gensym4 == "h") and
        not (("help", "print this cligen-erated help")[1] ==
            cf`gensym2.hTabSuppress):
        add(tab, helpHelpRow`gensym4)
    elif
      not (("help", "print this cligen-erated help")[1] ==
          cf`gensym2.hTabSuppress):
      add(tab, helpHelpRow`gensym4)
    if
      0 < len(cf`gensym2.helpSyntax) and
      not (("help-syntax", "advanced: prepend,plurals,..")[1] ==
          cf`gensym2.hTabSuppress) and
        not skipHelp:
      add(tab, @["--help-syntax", "", "",
                 ("help-syntax", "advanced: prepend,plurals,..")[1]])
    ap.shortNoVal = {shortH`gensym4[0]}
    ap.longNoVal = @["help", "help-syntax"]
    let setByP: ptr seq[ClParse] = cgSetByParseNil
    proc mayRend(x`gensym4: string): string =
      result = if (
        not (cf`gensym2.render == nil)): cf`gensym2.render(x`gensym4)
      else:
        x`gensym4

    if (
      0 < len(cf`gensym2.version)):
      add(allParams, "version")
      incl(crbt, optionNormalize("version", "_-"), "version")
      ap.parNm = "version"
      ap.parSh = "\x00"
      ap.parReq = 0
      ap.parRend = ("version", "print version")[0]
      if (
        not (("version", "print version")[1] == cf`gensym2.hTabSuppress)):
        add(tab, argHelp(false, ap) & ("version", "print version")[1])
    var fooParamDispatch = 'x'
    var fooParamDefault = fooParamDispatch
    ap.parNm = "foo"
    ap.parSh = "f"
    ap.parReq = 0
    ap.parRend = if (
      false): "" else: helpCase("foo", clLongOpt)
    let descr`gensym6 = getDescription(fooParamDispatch, "foo", "")
    if (
      not (descr`gensym6 == cf`gensym2.hTabSuppress)):
      add(tab, argHelp(fooParamDispatch, ap) & mayRend(descr`gensym6))
    if (
      not (ap.parReq == 0)):
      tab[BackwardsIndex(1)][2] = ap.val4req
    incl(crbt, optionNormalize("foo", "_-"), move(ap.parRend))
    add(allParams, helpCase("foo", clLongOpt))
    let ww`gensym7 = wrapWidth(cf`gensym2.widthEnv, ttyWidth)
    let indentDoc`gensym7 = addPrefix(prefix, wrap(mayRend(""), ww`gensym7, 3,
        len(prefix)))
    proc hl(tag`gensym7, val`gensym7: string): string =
      result = getOrDefault(cf`gensym2.helpAttr, tag`gensym7, "") & val`gensym7 &
          getOrDefault(cf`gensym2.helpAttrOff, tag`gensym7, "")

    let use`gensym7 = if noHdr: if (
      0 < len(cf`gensym2.use)): cf`gensym2.use
    else:
      usage
     else: if (
      0 < len(cf`gensym2.useHdr)): cf`gensym2.useHdr else: clUseHdr &
        if (
      0 < len(cf`gensym2.use)): cf`gensym2.use else: usage
    ap.help = use`gensym7 %
        ["doc", hl("doc", indentDoc`gensym7), "command", hl("cmd", "x"), "args",
         hl("args", "[optional-params] "), "options", addPrefix(prefix & "  ", alignTable(
        tab, 2 * len(prefix) + 2, cf`gensym2.hTabColGap, cf`gensym2.hTabMinLast,
        cf`gensym2.hTabRowSep, toInts(cf`gensym2.hTabCols), onCols(cf`gensym2),
        offCols(cf`gensym2), "", ww`gensym7, printedLen))]
    if
      0 < len(ap.help) and
      not (ap.help[BackwardsIndex(1)] == '\n'):
      ap.help &= "\n"
    if (
      0 < len(prefix)):
      ap.help = addPrefix(prefix, ap.help)
    var keyCount = initCountTable(32)
    proc parser(args`gensym17 = cmdline; provideDflAlias = true) =
      var posNo = 0
      var p = initOptParser(args`gensym17, ap.shortNoVal, ap.longNoVal,
                            cf`gensym2.reqSep, cf`gensym2.sepChars,
                            cf`gensym2.opChars, @[], cf`gensym2.longPfxOk,
                            cf`gensym2.stopPfxOk)
      while true:
        next(p)
        if p.kind == cmdEnd:
          break
        if p.kind == cmdError:
          if (
            not (cast[pointer](setByP) == cgSetByParseNil)):
            add(setByP[], ("", "", move(p.message), clParseOptErr))
          if not parseOnly:
            write(stderr, [p.message, "\n"])
          break
        case p.kind
        of cmdLongOption, cmdShortOption:
          case if p.kind == cmdLongOption: lengthen(crbt, p.key,
              cf`gensym2.longPfxOk)
          else:
            p.key
          of "help", "h":
            if (
              not (cast[pointer](setByP) == cgSetByParseNil)):
              add(setByP[], ("help", "", ap.help, clHelpOnly))
            if not parseOnly:
              write(stdout, ap.help)
              raise
                (ref HelpOnly)(msg: "", parent: nil)
          of "helpsyntax":
            if (
              not (cast[pointer](setByP) == cgSetByParseNil)):
              add(setByP[],
                  ("helpsyntax", "", cf`gensym2.helpSyntax, clHelpOnly))
            if not parseOnly:
              write(stdout, cf`gensym2.helpSyntax)
              raise
                (ref HelpOnly)(msg: "", parent: nil)
          of "version", "\x00":
            if (
              not (cast[pointer](setByP) == cgSetByParseNil)):
              add(setByP[], ("version", "", cf`gensym2.version, clVersionOnly))
            if not parseOnly:
              if (
                0 < len(cf`gensym2.version)):
                write(stdout, [cf`gensym2.version, "\n"])
                raise
                  (ref VersionOnly)(msg: "", parent: nil)
              else:
                write(stdout, "Unknown version\n")
                raise
                  (ref VersionOnly)(msg: "", parent: nil)
          of "foo", "f":
            ap.key = p.key
            ap.val = p.val
            ap.sep = p.sep
            ap.parNm = "foo"
            ap.parRend = helpCase("foo", clLongOpt)
            inc(keyCount, "foo", 1)
            ap.parCount = keyCount["foo"]
            if (
              not (cast[pointer](setByP) == cgSetByParseNil)):
              if argParse(fooParamDispatch, fooParamDefault, ap):
                add(setByP[], ("foo", move(p.val), "", clOk))
              else:
                add(setByP[], ("foo", move(p.val),
                               "Cannot parse arg to " & ap.key, clBadVal))
            if not parseOnly:
              if not argParse(fooParamDispatch, fooParamDefault, ap):
                write(stderr, ap.msg)
                raise
                  (ref ParseError)(msg: "Cannot parse arg to " & ap.key,
                                   parent: nil)
            discard delItem(mand, "foo")
          of "":
            let ks`gensym13 = valsWithPfx(crbt, p.key)
            let msg`gensym13 = "Ambiguous long option prefix \"$1\" matches:\n  $2 " %
                [p.key, join(ks`gensym13, "\n  ")] &
                "\nRun with --help for more details.\n"
            if (
              not (cast[pointer](setByP) == cgSetByParseNil)):
              add(setByP[], (move(p.key), move(p.val), msg`gensym13, clBadKey))
            if not parseOnly:
              write(stderr, msg`gensym13)
              raise
                (ref ParseError)(msg: "Unknown option", parent: nil)
          else:
            var
              mb`gensym14: string
              k`gensym14: string
            k`gensym14 = "short"
            if p.kind == cmdLongOption:
              k`gensym14 = "long"
              var idNorm`gensym14: seq[string]
              for id`gensym14 in items(allParams):
                add(idNorm`gensym14, optionNormalize(id`gensym14, "_-"))
              let sugg`gensym14 = suggestions(optionNormalize(p.key, "_-"),
                  idNorm`gensym14, allParams, 3, C(4))
              if (
                0 < len(sugg`gensym14)):
                mb`gensym14 &=
                    "Maybe you meant one of:\n\t" & join(sugg`gensym14, " ") &
                    "\n\n"
            let msg`gensym14 = "Unknown " & k`gensym14 & " option: \"" & p.key &
                "\"\n\n" &
                mb`gensym14 &
                "Run with --help for full usage.\n"
            if (
              not (cast[pointer](setByP) == cgSetByParseNil)):
              add(setByP[], (move(p.key), move(p.val), msg`gensym14, clBadKey))
            if not parseOnly:
              write(stderr, msg`gensym14)
              raise
                (ref ParseError)(msg: "Unknown option", parent: nil)
        else:
          let msg`gensym15 = "Unexpected non-option " & $p.key
          if (
            not (cast[pointer](setByP) == cgSetByParseNil)):
            add(setByP[],
                (move(ap.key), move(p.val), msg`gensym15, clNonOption))
          if not parseOnly:
            write(stderr, "x does not expect non-option arguments at \"" &
                $p.key &
                "\".\nRun with --help for full usage.\n")
            raise
              (ref ParseError)(msg: msg`gensym15, parent: nil)

    {.pop.}
    parser(cmdline, true)
    if (
      0 < len(mand)):
      if (
        not (cast[pointer](setByP) == cgSetByParseNil)):
        for m`gensym17 in items(mand):
          add(setByP[], (m`gensym17, "", "Missing " & m`gensym17, clMissing))
      if not parseOnly:
        write(stderr, "Missing these required parameters:\n")
        for m`gensym17 in items(mand):
          write(stderr, ["  ", m`gensym17, "\n"])
        write(stderr, "Run command with --help for more details.\n")
        raise
          (ref ParseError)(msg: "Missing one/some mandatory args", parent: nil)
    if parseOnly or
      not (cast[pointer](setByP) == cgSetByParseNil) and
      0 < numOfStatus(setByP[], ClNoCall):
      return
    x(fooParamDispatch)

  try:
    dispatchx(mergeParams([""], commandLineParams()), clUse, "", false, false,
              false)
    quit(0)
  except HelpOnly, VersionOnly:
    quit(0)
  except ParseError:
    quit(cgParseErrorExitCode)


cligenScope(clCfg)

```

- Cligen can not compile for JavaScript targets.
- Uses `cast`, `ref`, `nil`, `addr`, unsafe code, etc.
- Run-time string concatenations `&`.
- Several `for` loops.
- Several `import` and `export` from stdlib, several public symbols.
- [Wont work with `template`, `macro`, anonimous `func`.](https://github.com/juancarlospaco/cliche/blob/nim/examples/example_cligen_err.nim)
- Abbreviated CLI arguments (`--bar` is duplicated as `-b` too?).
- [C Compilation warnings.](https://github.com/juancarlospaco/cliche/blob/nim/examples/cligen_compilation.md#c-compilation-warnings-in-cligen)
- API enforces to use `proc`.


Lets use Cliche:

```nim
import std/[macros, os, strutils], cliche
expandMacros:
  commandLineParams().getOpt (foo: 'x')
doAssert foo == 'z'
```

Expands to:

```nim
var foo = 'x'
for v in commandLineParams():
  var sepPos: int
  var k, b: string
  if not(v.len > 3) or v[0] != '-'  or v[1] != '-': continue
  if v.len == 6 and v[0] == 'h' and v[1] == 'e' and v[2] == 'l' and v[3] == 'p':
    quit(apiExplained, 0)
  if len(v) == 8 and v[2] == 'x' and v[3] == 'd' and v[4] == 'e' and v[5] == 'b' and v[6] == 'u' and v[7] == 'g':
    quit(debuginfos, 0)
  for x in 2 .. v.len:
    if v[x] == '=':
      sepPos = x
      break
  k = v[2 ..< sepPos]
  b = v[sepPos .. ^1]
  if k.len == 3 and k[0] == 'f' and k[1] == 'o' and k[2] == 'o':
    foo = char(b[0])
```

- Cliche works for JavaScript targets [(Use with nodejs package)](https://github.com/juancarlospaco/nodejs#alternative-stdlib-for-nim-for-nodejsjavascript-targets).
- No `cast`, no `ref`, no `nil`, no `addr`, no unsafe code.
- Compile-time string ops.
- **1** `for` loop.
- 2 `import`, 0 `export` from stdlib, 1 public symbol.
- Works with `template`, `macro`, etc.
- No support for abbreviated CLI arguments (`--foo` in CLI is `foo` in code).
- API just uses variables.
- Supports `enum`, `Positive`, `Natural`, `BiggestUInt`, `BiggestInt`, `BiggestFloat`, `byte`, `cint`, `cfloat`.
- Fallbacks for values: static default :arrow_right: env var :arrow_right: command line


# Stars

![](https://starchart.cc/juancarlospaco/cliche.svg)
:star: [@juancarlospaco](https://github.com/juancarlospaco '2022-02-16')
:star: [@nikitavoloboev](https://github.com/nikitavoloboev '2022-02-16')
:star: [@zargot](https://github.com/zargot '2022-02-22')
:star: [@artemklevtsov](https://github.com/artemklevtsov '2022-02-23')
:star: [@AndrielFR](https://github.com/AndrielFR '2022-02-27')
:star: [@jaco-codexorbis](https://github.com/jaco-codexorbis '2022-03-20')
:star: [@nonimportant](https://github.com/nonimportant '2022-04-03')
:star: [@hamidb80](https://github.com/hamidb80 '2022-05-07')
:star: [@bichanna](https://github.com/bichanna '2022-05-07')
:star: [@hugosenari](https://github.com/hugosenari '2022-06-01')
:star: [@Infinitybeond1](https://github.com/Infinitybeond1 '2022-07-20')
:star: [@kamilchm](https://github.com/kamilchm '2022-08-17')
:star: [@pedrovhb](https://github.com/pedrovhb '2022-08-25')
:star: [@foxoman](https://github.com/foxoman '2022-11-16')
:star: [@pietroppeter](https://github.com/pietroppeter '2022-11-19')	
:star: [@srozb](https://github.com/srozb '2022-11-20')	
:star: [@xilicode](https://github.com/xilicode '2022-11-26')	
:star: [@ccamateur](https://github.com/ccamateur '2022-12-27')	
:star: [@ThomasTJdev](https://github.com/ThomasTJdev '2023-01-11')	
:star: [@dsrw](https://github.com/dsrw '2023-01-11')	
:star: [@sirredbeard](https://github.com/sirredbeard '2023-01-11')	
:star: [@mrgaturus](https://github.com/mrgaturus '2023-01-11')	
:star: [@maleyva1](https://github.com/maleyva1 '2023-01-11')	
:star: [@jacob-2](https://github.com/jacob-2 '2023-01-12')	
:star: [@sevagh](https://github.com/sevagh '2023-01-12')	
:star: [@elcritch](https://github.com/elcritch '2023-01-13')	
:star: [@teroz](https://github.com/teroz '2023-01-13')	
:star: [@Kesefon](https://github.com/Kesefon '2023-01-13')	
