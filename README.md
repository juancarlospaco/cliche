# CLIche

- AutoMagic CLI argument parsing is so Cliché.

![](cliche.jpg "Image is so Cliché")


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

* Auto-Generated `--help`

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
 --help  ?       Some Help Message Here!'

$
```
