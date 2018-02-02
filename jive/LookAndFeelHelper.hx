package jive;

import flash.system.Capabilities;

class LookAndFeelHelper {
    public static var maxDimension(get, null): Float;
    private static var _maxDimension: Float = -1.0;
    private static function get_maxDimension(): Float {
        if (_maxDimension < 0) {
            _maxDimension = Math.max(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
        }
        return _maxDimension;
    }

    public static var minDimension(get, null): Float;
    private static var _minDimension: Float = -1.1;
    private static function get_minDimension(): Float {
        if (_minDimension < 0) {
            _minDimension = Math.min(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
        }
        return _minDimension;
    }

    public static var scale(get, null): Float;
    private static var _scale: Float = -1.1;
    private static function get_scale(): Float {
        if (_scale < 0) {
            _scale = Math.floor(Math.min(LookAndFeelHelper.minDimension * 0.350, 0.350 * 2/3 * LookAndFeelHelper.maxDimension))/112;
        }
        return _scale;
    }
}
