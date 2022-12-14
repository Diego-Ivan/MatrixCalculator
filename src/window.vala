/* window.vala
 *
 * Copyright 2022 Diego Iván
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

namespace MatrixOperator {
    [GtkTemplate (ui = "/io/github/diegoivan/matrixoperator/window.ui")]
    public class Window : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.Box main_box;

        private MatrixGrid matrix_grid = new MatrixGrid (new Matrix (3,4));

        public Window (Gtk.Application app) {
            Object (application: app);
        }

        construct {
            var add_button = new Gtk.Button.with_label ("Add a Row");
            var remove_button = new Gtk.Button.with_label ("Remove a row");
            var new_column_button = new Gtk.Button.with_label ("Add a new Column");
            var remove_column_button = new Gtk.Button.with_label ("Remove column");
            var serialize_button = new Gtk.Button.with_label ("Serialize");
            var swap = new Gtk.Button.with_label ("Swap Rows");
            main_box.append (matrix_grid);
            main_box.append (add_button);
            main_box.append (remove_button);
            main_box.append (new_column_button);
            main_box.append (remove_column_button);
            main_box.append (serialize_button);
            main_box.append (swap);

            add_button.clicked.connect (() => {
                matrix_grid.query_add_row ();
            });

            remove_button.clicked.connect (()=> {
                matrix_grid.query_remove_row ();
            });

            new_column_button.clicked.connect (() => {
                matrix_grid.query_add_column ();
            });

            remove_column_button.clicked.connect (() => {
                matrix_grid.query_remove_column ();
            });

            serialize_button.clicked.connect (() => {
                print (matrix_grid.matrix.str_serialize ());
            });

            swap.clicked.connect (() => {
                matrix_grid.query_swap (2, 0);
            });
        }
    }
}
