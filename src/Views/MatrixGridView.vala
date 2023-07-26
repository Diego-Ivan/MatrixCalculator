/* MatrixGridView.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Matrices.Views.MatrixGridView : Gtk.Grid {
    private Models.MatrixModel _matrix_model;
    public Models.MatrixModel matrix_model {
        get {
            return _matrix_model;
        }
        set {
            _matrix_model = value;
            if (factory != null) {
                remove_all_children ();
                populate ();
            }
        }
    }

    private Factories.MatrixWidgetFactory _factory;
    public Factories.MatrixWidgetFactory factory {
        get {
            return _factory;
        }
        set {
            _factory = value;

            if (matrix_model != null) {
                remove_all_children ();
                populate ();
            }
        }
    }

    protected void populate () {
        for (int i = 0; i < matrix_model.rows; i++) {
            for (int j = 0; j < matrix_model.columns; j++) {
                var item = new Models.MatrixItem () {
                    value = matrix_model[i,j],
                    row = i,
                    column = j
                };
                attach (factory.create_matrix_widget_for_item (item), j, i);
            }
        }
    }

    protected void remove_all_children () {
        Gtk.Widget? child = get_first_child ();
        while (child != null) {
            Gtk.Widget? next = child.get_next_sibling ();
            remove (child);
            child = next;
        }
    }
}
