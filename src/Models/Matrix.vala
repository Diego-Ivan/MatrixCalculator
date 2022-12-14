/* Matrix.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MatrixOperator.Matrix : Object {
    private Gee.LinkedList<Row> rows = new Gee.LinkedList<Row> ();

    public int n_rows {
        get {
            return rows.size;
        }
    }

    public int n_columns {
        get {
            return rows.get (0).n_columns;
        }
    }

    public signal void row_added (int index);
    public signal void row_removed (int row_index);
    public signal void column_removed (int row_index, int column_index);
    public signal void column_added (int row_index, int column_index);
    public signal void element_modified (int row_index, int column_index);

    public Matrix (int n_rows, int n_columns)
        requires(n_rows > 0 && n_columns > 0)
    {
        for (int i = 0; i < n_rows; i++) {
            add_row (n_columns);
        }
    }

    public void add_row (int columns)
        requires (columns > 0)
    {
        var row = new Row (columns);
        rows.add (row);
        row.column_modified.connect (on_column_modified);
        row_added (n_rows - 1);
    }

    public void add_column ()
        ensures (all_rows_are_equal_sized ())
    {
        for (int i = 0; i < n_rows; i++) {
            rows.get (i).add_column ();
            column_added (i, n_columns - 1);
        }
    }

    public void remove_row (int index)
        requires (index >= 0)
        requires (index < n_rows)
    {
        rows.remove_at (index);
        row_removed (index);
    }

    public void remove_column (int column_index)
        ensures (all_rows_are_equal_sized ())
    {
        for (int i = 0; i < n_rows; i++) {
            rows.get(i).delete_column (column_index);
            print ("Removing Column %i from row %i\n", column_index, i);
            column_removed (i, column_index);
        }
    }

    public void set_value_at (int row_index, int column_index, double value)
        requires (row_index >= 0 && column_index >= 0)
        requires (row_index < n_rows)
    {
        Row row = rows.get (row_index);
        double current_value = row.get_value_at_index (column_index);

        // Let's avoid sending signals in case the value is the same
        if (current_value == value) {
            message ("Same value found!");
            return;
        }
        row.set_value_at_index (column_index, value);

        message ("Value of row %i, column %i has been changed", row_index, column_index);
    }

    public double get_value_at (int row_index, int column_index)
        requires (row_index >= 0 && column_index >= 0)
        requires (row_index < n_rows)
    {
        var row = rows.get (row_index);
        return row.get_value_at_index (column_index);
    }

    public string str_serialize () {
        var builder = new StringBuilder ("{\n");
        int columns = n_columns;
        for (int i = 0; i < n_rows; i++) {
            var row = rows.get (i);
            builder.append ("\t");

            for (int j = 0; j < columns; j++) {
                double value = row.get_value_at_index (j);
                builder.append_printf ("%s%s", value.to_string (), j == columns-1? "\n" :",");
            }
        }
        builder.append ("}");
        return builder.str;
    }

    private bool all_rows_are_equal_sized () {
        for (int i = 1; i < n_rows; i++) {
            Row previous = rows.get (i - 1);
            Row current = rows.get (i);

            message ("Previous Counter: %i, Current Counter: %i", previous.n_columns, current.n_columns);

            if (previous.n_columns != current.n_columns) {
                return false;
            }
        }
        return true;
    }

    private void on_column_modified (Row source, int column_index) {
        element_modified (get_row_index (source), column_index);

        message (source.n_columns.to_string ());
    }

    private int get_row_index (Row row) {
        return rows.index_of (row);
    }
}
