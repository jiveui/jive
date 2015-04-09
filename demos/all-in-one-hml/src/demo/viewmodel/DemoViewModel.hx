package demo.viewmodel;

import openfl.Assets;
import flash.display.DisplayObject;
import org.aswing.VectorListModel;
import bindx.IBindable;

class DemoViewModel implements IBindable {

    @bindable public var buttonsVM: ButtonsViewModel = new ButtonsViewModel();
    @bindable public var textVM: TextViewModel = new TextViewModel();
    @bindable public var progressVM: ProgressViewModel = new ProgressViewModel();
    @bindable public var comboboxVM: ComboBoxViewModel = new ComboBoxViewModel();

    @bindable public var menuSelectedIndex: Int;

    public function new() {
        menuSelectedIndex = 0;
    }
}
