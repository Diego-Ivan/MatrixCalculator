matrixoperator_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
]

matrixoperator_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1'),
  dependency('gee-0.8'),
]

matrixoperator_sources += gnome.compile_resources('matrixoperator-resources',
  'matrixoperator.gresource.xml',
  c_name: 'matrixoperator'
)

executable('matrixoperator', matrixoperator_sources,
  dependencies: matrixoperator_deps,
       install: true,
)
