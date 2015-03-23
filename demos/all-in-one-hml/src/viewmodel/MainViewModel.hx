package viewmodel;

import openfl.Assets;
import flash.display.DisplayObject;
import org.aswing.VectorListModel;
import bindx.IBindable;

class MainViewModel implements IBindable {

    @bindable public var buttonsVM: ButtonsViewModel = new ButtonsViewModel();
    @bindable public var textVM: TextViewModel = new TextViewModel();

    @bindable public var menuSelectedIndex: Int;
    @bindable public var menuListModel: VectorListModel;

    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-light.svg");

    public function new() {
        menuListModel = new VectorListModel(["Buttons", "Text fields"]);
        menuSelectedIndex = 0;
    }
}
