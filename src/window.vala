/* window.vala
 *
 * Copyright 2022-2023 Diego Iván
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Matrices {
    [GtkTemplate (ui = "/io/github/diegoivan/matrixoperator/window.ui")]
    public class Window : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Views.MatrixGridView grid_view;
        public Window (Gtk.Application app) {
            Object (application: app);
        }

        construct {
            var square_matrix = new Models.SquareMatrixModel (4);
            print (@"\n$square_matrix");
            grid_view.matrix_model = square_matrix;
            grid_view.factory = new Factories.SpinButtonWidgetFactory ();
        }

        [GtkCallback]
        private void on_random_button_clicked () {
            Models.MatrixModel model = grid_view.matrix_model;
            int rand_row = Random.int_range (0, model.rows);
            int rand_column = Random.int_range (0, model.columns);
            int rand_value = Random.int_range (-10, 10);

            debug (@"Randomly setting $rand_row,$rand_column to $rand_value");
            model[rand_row, rand_column] = rand_value;
            print (@"\n$model");
        }
    }
}
