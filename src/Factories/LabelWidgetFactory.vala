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

    private double _value;
    public override double value {
        get {
            return _value;
        }
        set {
            _value = value;
            label.label = this.value.to_string ();
            debug ("Value changed");
        }
    }

    public LabelMatrixWidget (Models.MatrixItem matrix_item) {
        this.value = matrix_item.value;
    }

    construct {
        child = label;
    }
}
