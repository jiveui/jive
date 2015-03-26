package jive.tools;

import flash.text.TextFormat;

class TextFormatTools {

    public static function clone(tf: TextFormat):TextFormat {

        var newFormat = new TextFormat (tf.font, tf.size, tf.color, tf.bold, tf.italic, tf.underline, tf.url, tf.target);

        newFormat.align = tf.align;
        newFormat.leftMargin = tf.leftMargin;
        newFormat.rightMargin = tf.rightMargin;
        newFormat.indent = tf.indent;
        newFormat.leading = tf.leading;

        newFormat.blockIndent = tf.blockIndent;
        newFormat.bullet = tf.bullet;
        newFormat.kerning = tf.kerning;
        newFormat.letterSpacing = tf.letterSpacing;
        newFormat.tabStops = tf.tabStops;

        return newFormat;

    }
}
