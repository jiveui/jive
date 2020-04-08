package jive;

import openfl.geom.Matrix;
class GeometryHelper {
    public static function createRotationMatric(angle: Float, pivotX: Float, pivotY: Float) {
        var matrix:Matrix = new Matrix();
        if (angle != 0.0) {
            matrix.translate(-pivotX, -pivotY);
            matrix.rotate(angle / 180.0 * Math.PI);
            matrix.translate(pivotX, pivotY);
        }
        return matrix;
    }
}