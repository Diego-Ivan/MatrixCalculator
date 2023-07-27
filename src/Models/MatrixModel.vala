/* MatrixModel.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
 * The base class for Matrix model implementations with equal number of rows and columns
 */
public abstract class Matrices.Models.MatrixModel : Object {
    /**
     *  Signal emitted when the value of an item in the matrix has changed.
     */
    public signal void value_changed (int row, int column);

    public abstract int rows { get; }
    public abstract int columns { get; }

    /**
     *  The method to get the value at M[row,column]. The indexes should be array-like, not
     *  as the mathematical representation. For instance, the first value at the first column is
     *  M[0,0], instead of M[1,1]
     */
    public abstract new double @get (int row, int column);

    /**
     * The method to gset the value at M[row,column]. Follows the same syntax as the get method
     */
    public abstract new void @set (int row, int column, double @value);

    public virtual string to_string () {
        var builder = new StringBuilder ("{\n");
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                string next_char = j == columns-1 ? "\n" : ", ";
                builder.append (@"$(this[i,j])$next_char");
            }
        }
        builder.append ("\n}");
        return builder.str;
    }
}
