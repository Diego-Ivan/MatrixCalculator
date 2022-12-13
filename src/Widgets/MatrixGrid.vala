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

            // Connect the signals of the matrix
            matrix.row_added.connect (on_row_added);
            matrix.row_removed.connect (on_row_removed);
            matrix.column_added.connect (on_column_added);
            matrix.column_removed.connect (on_column_removed);

            print (matrix.str_serialize ());
        }
    }

    public MatrixGrid (Matrix matrix) {
        Object (matrix: matrix);
    }

    public void query_add_row ()
    {
        matrix.add_row (matrix.n_columns);
    }

    public void query_remove_row () {
        matrix.remove_row (matrix.n_rows - 1);
    }

    public void query_add_column () {
        matrix.add_column ();
    }

    public void query_remove_column () {
        matrix.remove_column (matrix.n_columns - 1);
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
        unowned Gtk.Widget? reference_sibling = get_child_at (0, row_index - 1);

        if (row_index == 0) {
            position = TOP;
            reference_sibling = get_child_at (0, 0);
        }

        // Get the first value in the desired row. Create a label with said value, and attach it
        double first_value = matrix.get_value_at (row_index, 0);
        Gtk.Widget first_of_the_row = create_widget (first_value);
        attach_next_to (first_of_the_row, reference_sibling, position);

        /*
         * Now that we have allocated space in a row, we can start attaching widgets in said row!
         */
        int n_columns = matrix.n_columns;
        for (int i = 1; i < n_columns; i++) {
            double value = matrix.get_value_at (row_index, i);
            attach (create_widget (value), i, row_index);
        }
    }

    private void on_row_removed (int row_index) {
        remove_row (row_index);
    }

    private void on_column_added (int row_index, int column_index) {
        unowned Gtk.Widget? sibling = get_child_at (column_index - 1, row_index);
        double value = matrix.get_value_at (row_index, column_index);
        attach_next_to (create_widget (value), sibling, RIGHT);
    }

    private void on_column_removed (int row_index, int column_index) {
        Gtk.Widget child_removed = get_child_at (column_index, row_index);
        remove (child_removed);
    }

    private void on_entry_modified (NumberEntry source, double value) {
        int column, row, width, height;
        query_child (source, out column, out row, out width, out height);
        matrix.set_value_at (row, column, value);
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
        var entry = new NumberEntry (value);
        entry.valid_expression_found.connect (on_entry_modified);

        return entry;
    }
}
