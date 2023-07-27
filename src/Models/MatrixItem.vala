/* MatrixItem.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Matrices.Models.MatrixItem : Object {
    public double value { get; set; }
    public int row { get; set; }
    public int column { get; set; }
    public unowned MatrixModel matrix_model { get; set; }
}
