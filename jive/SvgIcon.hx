package jive;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.Assets;
import org.aswing.AssetIcon;

class SvgIcon extends AssetIcon {

    override private function set_width(v: Int): Int {
        super.set_width(v);
        updateAsset();
        return v;
    }

    override private function set_height(v: Int): Int {
        super.set_height(v);
        updateAsset();
        return v;
    }

    public var assetName(get, set): String;
    private var _assetName: String;
    private function get_assetName(): String { return _assetName; }
    private function set_assetName(v: String): String {
        _assetName = v;
        updateAsset();
        return v;
    }

    public var cacheAsBitmap(get, set): Bool;
    private var _cacheAsBitmap: Bool;
    private function get_cacheAsBitmap(): Bool { return _cacheAsBitmap; }
    private function set_cacheAsBitmap(v: Bool): Bool {
        _cacheAsBitmap = v;
        updateAsset();
        return v;
    }

    public function new(assetName: String = null, width: Int = -1, height: Int = -1, cacheAsBitmap: Bool = false) {
        super(null, width, height);
        _cacheAsBitmap = cacheAsBitmap;
        this.assetName = assetName;
    }

    private function updateAsset() {
        if (null != assetName) {
            var svg = new format.SVG(Assets.getText(assetName));
            var shape = new Shape();
            svg.render(shape.graphics, 0, 0, width-1, height-1);
            if (!_cacheAsBitmap) {
                asset = shape;
            } else {
                var data = new BitmapData(width, height, true, 0xFFFFFF);
                data.draw(shape, null, null, null, null, true);
                asset = new Bitmap(data, null, true);
            }
        }
    }
}
