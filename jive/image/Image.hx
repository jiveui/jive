package jive.image;

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

    var bitmap: Bitmap;

    public var bitmapData(default, set): BitmapData;
    private function set_bitmapData(v: BitmapData): BitmapData {

        if (null != bitmapData) bitmapData.dispose();
        bitmapData = v;

        if (null == width || width == Metric.none) width = Metric.absolute(bitmapData.width);
        if (null == height || height == Metric.none) height = Metric.absolute(bitmapData.height);

        if (null != parent) parent.remove(this);
        displayObject = createDisplayObject();
        if (null != parent) parent.append(this);

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
        displayObject;
    }

    override private function createDisplayObject(): DisplayObject {
        bitmap = new Bitmap(bitmapData, PixelSnapping.AUTO, true);
        return bitmap;
    }

    override public function paint(size: IntDimension): IntDimension {

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
        var data = new BitmapData(Std.int(bitmapData.width * scaleX), Std.int(bitmapData.height * scaleY));
        m.scale(scaleX, scaleY);
        data.draw(bitmapData, m, null, null, null, true);

        bitmap.bitmapData = data;

        trace(size);
        trace(bitmapData.width);
        trace(bitmapData.height);
        trace(data.width);
        trace(data.height);

        return super.paint(new IntDimension(data.width, data.height));
    }
}
