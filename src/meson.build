matrixoperator_sources = [
  'main.vala',
  'application.vala',
  'window.vala',

  # Models
  'Models/MatrixModel.vala',
  'Models/SquareMatrixModel.vala',
  'Models/MatrixItem.vala',

  # Views
  'Views/MatrixGridView.vala',

  # Factories
  'Factories/MatrixWidgetFactory.vala',
  'Factories/LabelWidgetFactory.vala',
  'Factories/SpinButtonWidgetFactory.vala',
]

matrixoperator_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1'),
]

matrixoperator_sources += gnome.compile_resources('matrixoperator-resources',
  'matrixoperator.gresource.xml',
  c_name: 'matrixoperator'
)

executable('matrixoperator', matrixoperator_sources,
  dependencies: matrixoperator_deps,
       install: true,
)
