/* MatrixModel.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
 * A square matrix implementation of @class.MatrixModel
 */
public class Matrices.Models.SquareMatrixModel : MatrixModel {
    private Row[] matrix;

    private int _size;
    public int size {
        get {
            return _size;
        }
        construct {
            _size = value;
            matrix = new Row[size];
            for (int i = 0; i < size; i++) {
                matrix[i] = new Row (size);
            }
        }
    }

    public override int rows {
        get {
            return size;
        }
    }

    public override int columns {
        get {
            return size;
        }
    }

    public SquareMatrixModel (int size)
        requires (size > 0)
    {
        Object (size: size);
    }

    public override double @get (int row, int column)
        requires (is_valid_space (row, column))
    {
        return matrix[row][column];
    }

    public override void @set (int row, int column, double @value)
        requires (is_valid_space (row, column))
    {
        double current_value = matrix[row][column];
        if (current_value == value) {
            // We'll avoid setting the same value.
            debug ("Same value being set detected! Exiting setter");
            return;
        }

        debug (@"Value at: $row,$column has changed: $current_value -> $value");

        matrix[row][column] = @value;
        value_changed (row, column);
    }

    private inline bool is_valid_space (int row, int column) {
        return row * column < size * size;
    }

    /**
     * This class is used to store rows for the SquareMatrixModel
     * It does not make out-of-bounds checks, as it should be done by SquareMatrixModels
     */
    [Compact (opaque = true)]
    private class Row {
        public double[] values { get; set; }
        public Row (int size)
            requires (size >= 0)
        {
            values = new double[size];
            for (int i = 0; i < size; i++) {
                values[i] = 0;
            }
        }

        public double @get (int column) {
            return values[column];
        }

        public void @set (int column, double value) {
            values[column] = value;
        }
    }
}
