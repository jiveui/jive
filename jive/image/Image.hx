package jive.image;

import jive.geom.Metric;
import openfl.display.PixelSnapping;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;

import jive.geom.IntDimension;
import jive.geom.MetricDimension;

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

        //TODO: implement scale and keepRatio
        return super.paint(size);
    }
}
