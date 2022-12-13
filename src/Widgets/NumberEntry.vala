/* NumberEntry.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MatrixOperator.NumberEntry : Gtk.Entry {
    private bool _is_number;
    public bool is_number {
        get {
            return _is_number;
        }
        set {
            _is_number = value;
            if (is_number) {
                remove_css_class ("error");
                return;
            }
            add_css_class ("error");
        }
    }
    public signal void valid_expression_found (double @value);

    public NumberEntry (double value) {
        Object (
            text: value.to_string ()
        );
    }

    construct {
        changed.connect (on_changed);
    }

    private void on_changed () {
        /*
         * The Entry will be able to know if the expression is a fraction and send it as number.
         */
        double? n = null;
        if (!double.try_parse (text, out n)) {
            /*
             * Here we are looking for an expression with the form "number/number", therefore, we don't want
             * more or less than 2 values in there,
             */
            string[]? numbers = text.split ("/");
            if (numbers.length != 2 || numbers == null) {
                is_number = false;
                return;
            }

            /*
             * Here, we will be placing the values in a buffer, and we will determine if those are numbers
             * or not
             */
            double?[] value_buffer = new double?[2];
            for (int i = 0; i < numbers.length; i++) {
                assert (numbers[i] != null);
                if (!double.try_parse (numbers[i], out value_buffer[i]) || numbers[i] == "") {
                    is_number = false;
                    return;
                }
                assert (value_buffer[i] != null);
            }

            // Solving division
            n = value_buffer[0] / value_buffer[1];
        }

        assert (n != null);
        is_number = true;
        valid_expression_found (n);
    }
}
