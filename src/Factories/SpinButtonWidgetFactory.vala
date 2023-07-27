/* SpinButtonWidgetFactory.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Matrices.Factories.SpinButtonWidgetFactory : MatrixWidgetFactory {
    public override MatrixWidget create_matrix_widget_for_item (Models.MatrixItem item) {
        return new SpinButtonMatrixWidget (item);
    }
}

public class Matrices.SpinButtonMatrixWidget : Matrices.MatrixWidget {
    private double _value;
    public override double value {
        get {
            return _value;
        }
        set {
            this._value = value;
            matrix_item.matrix_model[matrix_item.row, matrix_item.column] = _value;
        }
    }

    private Models.MatrixItem _matrix_item;
    public Models.MatrixItem matrix_item {
        get {
            return _matrix_item;
        }
        set {
            _matrix_item = value;
            this.value = matrix_item.value;
        }
    }

    public SpinButtonMatrixWidget (Models.MatrixItem item) {
        Object (
            matrix_item: item,
            value: item.value
        );
    }

    construct {
        var spin_button = new Gtk.SpinButton.with_range (-1e6, 1e6, 1);
        child = spin_button;

        spin_button.adjustment.bind_property ("value", this, "value", SYNC_CREATE | BIDIRECTIONAL);
    }
}
