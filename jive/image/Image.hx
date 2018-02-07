package jive.image;


import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.Component;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;

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

    override private function paint(b: IntRectangle): Void {
        var m = new Matrix();
        var scaleX = 1.0;
        var scaleY = 1.0;

        if (scale) { 
            if (b.width != bitmapData.width || b.height != bitmapData.height) {
                var d = adjustSize(new IntDimension(b.width, b.height));
                b.width = d.width;
                b.height = d.height;
                scaleX = b.width / bitmapData.width;
                scaleY = b.height / bitmapData.height;
            }
        }

        m.scale(scaleX, scaleY);

        var g = graphics;
        g.clear();
        g.beginBitmapFill(bitmapData, m, false, true);
        g.drawRect(b.x, b.y, b.width, b.height);
        g.endFill();
    }

    override public function getPreferredSize(): IntDimension {
        return adjustSize(super.getPreferredSize());
    }

    private function adjustSize(size: IntDimension): IntDimension {
        var w = bitmapData.width;
        var h = bitmapData.height;

        if (size.width <= 0) size.width = 1000 * 1000;
        if (size.height <= 0) size.height = 1000 * 1000;

        if (keepRatio) {
            var scale = Math.min(size.width / w, size.height / h);
            size.width = Math.round(w * scale);
            size.height = Math.round(h * scale);
        }

        return size;
    }
}
