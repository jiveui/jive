package demo.viewmodel;

import flash.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.Assets;
import bindx.IBindable;

class AccordionViewModel implements IBindable implements Spotable  {

    @:bindable public var xmlSource: String = Assets.getText("assets/source/AccordionView.hml");
    @:bindable public var haxeSource: String = Assets.getText("assets/source/AccordionViewModel.hx");
    @:bindable public var haxeLogo: DisplayObject = new Bitmap(Assets.getBitmapData("haxe-logo.png"));

    @:bindable public var selectedSpotIndex(get, set): Int;
    private var _selectedSpotIndex: Int;
    private function get_selectedSpotIndex(): Int { return _selectedSpotIndex; }
    private function set_selectedSpotIndex(v: Int): Int {
        _selectedSpotIndex = v;
        return v;
    }

    public function new() {}
}
