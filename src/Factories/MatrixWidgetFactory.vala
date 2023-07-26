/* MatrixWidgetFactory.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public abstract class Matrices.Factories.MatrixWidgetFactory : Object {
    public abstract MatrixWidget create_matrix_widget_for_item (Models.MatrixItem item);
}

public abstract class Matrices.MatrixWidget : Adw.Bin {
    public abstract double value { get; set; }
}
