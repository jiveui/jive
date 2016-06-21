package jive.image;

import jive.geom.IntDimension;
import jive.geom.IntDimension;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import jive.geom.Metric;
import openfl.display.PixelSnapping;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;

import jive.geom.IntDimension;
import jive.geom.MetricDimension;

using jive.geom.MetricHelper;

class Image extends Component {

    public var bitmapData(default, set): BitmapData;
    private function set_bitmapData(v: BitmapData): BitmapData {

        if (null != bitmapData) bitmapData.dispose();
        bitmapData = v;
        repaint();

        return v;
    }

    public var scale(default, set): Bool;
    private function set_scale(v: Bool): Bool {
        scale = v;
        repaint();
        return v;
    }

    public var keepRatio(default, set): Bool;
    private function set_keepRatio(v: Bool): Bool {
        keepRatio = v;
        repaint();
        return v;
    }

    public function new() {
        super();
        scale = true;
        keepRatio = true;
    }

    override public function paint(size: IntDimension) {

        var m = new Matrix();
        var scaleX = 1.0;
        var scaleY = 1.0;
        if (scale) {
            if (keepRatio) {
                if (size.width / size.height > bitmapData.width / bitmapData.height) {
                    scaleY = size.height / bitmapData.height;
                    scaleX = scaleY;
                } else {
                    scaleY = size.width / bitmapData.width;
                    scaleX = scaleY;
                }
            } else {
                scaleX = size.width / bitmapData.width;
                scaleY = size.height / bitmapData.height;
            }
        }

        m.scale(scaleX, scaleY);

        var g = sprite.graphics;
        g.clear();
        g.beginBitmapFill(bitmapData, m, false, true);
        g.drawRect(0, 0, size.width, size.height);
        g.endFill();
    }

    override private function calcPreferredSize(): IntDimension {
        var d = super.calcPreferredSize();
        return if (null == bitmapData) new IntDimension(0,0)
            else
                if (d.width > 0 && d.height > 0) d
                else new IntDimension(bitmapData.width, bitmapData.height);
    }
}
