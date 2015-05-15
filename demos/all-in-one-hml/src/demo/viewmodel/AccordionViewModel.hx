package demo.viewmodel;

import openfl.Assets;
import bindx.IBindable;

class AccordionViewModel implements IBindable implements Spotable  {

    @bindable public var xmlSource: String = Assets.getText("assets/source/AccordionView.xml");
    @bindable public var haxeSource: String = Assets.getText("assets/source/AccordionViewModel.hx");

    @bindable public var selectedSpotIndex(get, set): Int;
    private var _selectedSpotIndex: Int;
    private function get_selectedSpotIndex(): Int { return _selectedSpotIndex; }
    private function set_selectedSpotIndex(v: Int): Int {
        _selectedSpotIndex = v;
        return v;
    }

    public function new() {}
}
