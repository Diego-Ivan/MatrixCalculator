/* Row.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MatrixOperator.Row {
    private Gee.LinkedList<double?> columns = new Gee.LinkedList<double?> ();
    public int n_columns {
        get {
            return columns.size;
        }
    }

    private int LAST_COLUMN {
        get {
            return n_columns - 1;
        }
    }

    public signal void column_modified (int index);

    public Row (int size)
        requires (size  >= 0)
    {
        for (int i = 0; i < size; i++) {
            add_column ();
        }
    }

    public void add_column () {
        columns.add (0);
    }

    public void delete_column (uint index)
        requires (index < n_columns)
    {
        columns.remove_at ((int) index);
    }

    public void set_value_at_index (uint index, double value)
        requires (index < n_columns)
    {
        columns.insert ((int) index, value);
        column_modified ((int) index);
    }

    public double get_value_at_index (uint index)
        requires (index < n_columns)
    {
        return columns.get ((int) index);
    }

    public void add_row (Row second_row)
        requires (second_row.n_columns == n_columns)
    {
        // Iterate over the second column and add it to the corresponding index
        for (int i = 0; i < n_columns; i++) {
            columns.insert (i, second_row.get_value_at_index (i));
            column_modified (i);
        }

    }

    public void multiply_row_and_add (Row second_row, double constant)
        requires (second_row.n_columns == n_columns)
    {
        for (int i = 0; i < n_columns; i++) {
            // Multiply value and add it to the corresponding index
            double value = second_row.get_value_at_index (i) * constant;
            columns.insert (i, value);
            column_modified (i);
        }
    }

    public void multiply_by_constant (double constant) {
        for (int i = 0; i < n_columns; i++) {
            double value = get_value_at_index (i) * constant;
            columns.insert (i, value);
            column_modified (i);
        }
    }

    public string str_serialize () {
        var builder = new StringBuilder ("[");
        for (int i = 0; i < n_columns; i++) {
            double value = columns.get (i);
            string next_char = i == n_columns - 1 ? "]" : ",";
            builder.append_printf ("%s%s", value.to_string (), next_char);
        }

        return builder.str;
    }
}
