package demo.viewmodel;

import openfl.Assets;
import bindx.IBindable;

class ProgressViewModel implements IBindable implements Spotable {

    @bindable public var isScrollbarIndeterminate: Bool = false;
    @bindable public var sliderValue: Int = 0;

    @bindable public var xmlSource: String = Assets.getText("assets/source/ProgressView.xml");
    @bindable public var haxeSource: String = Assets.getText("assets/source/ProgressViewModel.hx");

    @bindable public var selectedSpotIndex(get, set): Int;
    private var _selectedSpotIndex: Int;
    private function get_selectedSpotIndex(): Int { return _selectedSpotIndex; }
    private function set_selectedSpotIndex(v: Int): Int {
        _selectedSpotIndex = v;
        return v;
    }
    public function new() {}
}
