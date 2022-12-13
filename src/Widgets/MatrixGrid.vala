/* MatrixGrid.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MatrixOperator.MatrixGrid : Gtk.Grid {
    private Matrix _matrix;
    public Matrix matrix {
        get {
            return _matrix;
        }
        set {
            _matrix = value;
            populate ();
            print (matrix.str_serialize ());
        }
    }

    public MatrixGrid (Matrix matrix) {
        Object (matrix: matrix);
    }

    private void on_element_modified (int row, int column)
        requires (row >= 0 && column >= 0)
        requires (row < matrix.n_rows)
    {
        int n_columns = matrix.n_columns;
        return_if_fail (column < n_columns);

        Gtk.Label? child = (Gtk.Label?) get_child_at (row, column);
        assert (child != null);

        child.label = matrix.get_value_at (row, column).to_string ();
    }

    private void on_row_added (int row_index)
        requires (row_index >= 0)
    {
        /*
         * First, we have to take a reference sibling in order to know where should we put the widget. The default
         * behavious is picking the row above the desired one and putting it below. Nevertheless,this is not
         * met when the row is going to be put in the first one, given that the "row above" is null. So, we
         * have to check if the desired row is the first one in order to change the position :)
         */
        Gtk.PositionType position = BOTTOM;
        unowned Gtk.Label? reference_sibling = (Gtk.Label?) get_child_at (0, row_index - 1);

        if (row_index == 0) {
            position = TOP;
            reference_sibling = (Gtk.Label?) get_child_at (0, 0);
        }

        // Get the first value in the desired row. Create a label with said value, and attach it
        double first_value = matrix.get_value_at (row_index, 0);
        Gtk.Widget first_of_the_row = create_widget (first_value);
        attach_next_to (first_of_the_row, reference_sibling, position);


        int n_columns = matrix.n_columns;
    }

    private void populate () {
        int n_rows = matrix.n_rows;
        int n_columns = matrix.n_columns;

        for (int i = 0; i < n_rows; i++) {
            for (int j = 0; j < n_columns; j++) {
                double value = matrix.get_value_at (i, j);
                attach (create_widget (value), j, i);
            }
        }
    }

    private Gtk.Widget create_widget (double value) {
        return new Gtk.Label (value.to_string ());
    }
}
