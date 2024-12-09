project('shrine', ['swift', 'odin'],  # Note the array syntax for languages
  version : '0.1',
  default_options : [
    'warning_level=3',
    'buildtype=debug'  # Good during development
  ])

# You might want to set up compiler variables early
swift = meson.get_compiler('swift')
odin = meson.get_compiler('odin')

# Source setup
src = [
  'main.swift',
  'runtime.odin'
]

exe = executable('shrine', src,
  install : true)

test('basic', exe)
