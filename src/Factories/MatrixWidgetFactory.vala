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
    private Models.MatrixItem _matrix_item;
    public Models.MatrixItem matrix_item {
        get {
            return _matrix_item;
        }
        set {
            _matrix_item = value;
            matrix_item.bind_property ("value", this, "value", SYNC_CREATE | BIDIRECTIONAL);
        }
    }
    public abstract double value { get; set; }
}
