import cligen
block:
  template a(foo = 'x') = discard
  dispatch a
block:
  macro a(foo = 'x') = discard
  dispatch a
block:
  dispatch (func(foo = 'x') = discard)
