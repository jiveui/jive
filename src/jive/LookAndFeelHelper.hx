package jive;

import flash.system.Capabilities;

class LookAndFeelHelper {
    public static var maxDimension = Math.max(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
    public static var minDimension = Math.min(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
    public static var scale: Float = Math.floor(Math.min(LookAndFeelHelper.minDimension * 0.350, 0.350 * 2/3 * LookAndFeelHelper.maxDimension))/112;
}
