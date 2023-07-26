/* LabelWidgetFactory.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Matrices.Factories.LabelWidgetFactory : MatrixWidgetFactory {
    public override MatrixWidget create_matrix_widget_for_item (Models.MatrixItem item) {
        return new LabelMatrixWidget (item);
    }
}

public class Matrices.LabelMatrixWidget : MatrixWidget {
    private Gtk.Label label = new Gtk.Label ("");

    public override double value {
        get {
            return matrix_item.value;
        }
        set {
            label.label = value.to_string ();
        }
    }

    public LabelMatrixWidget (Models.MatrixItem matrix_item) {
        Object (matrix_item: matrix_item);
    }

    construct {
        child = label;
    }
}
