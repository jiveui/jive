package jive.image;

import openfl.Assets;

class AssetImage extends Image {

    public var assetId(default, set): String;
    private function set_assetId(v: String): String {
        assetId = v;
        bitmapData = Assets.getBitmapData(v);
        return v;
    }

    public function new() {
        super();
    }
}
