package viewmodel;

import openfl.Assets;
import flash.display.DisplayObject;
import org.aswing.VectorListModel;
import bindx.IBindable;

class MainViewModel implements IBindable {

    @bindable public var buttonsVM: ButtonsViewModel = new ButtonsViewModel();
    @bindable public var textVM: TextViewModel = new TextViewModel();
    @bindable public var progressVM: ProgressViewModel = new ProgressViewModel();
    @bindable public var comboboxVM: ComboBoxViewModel = new ComboBoxViewModel();

    @bindable public var menuSelectedIndex: Int;

    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-light.svg");

    @bindable public var xmlSource: String = Assets.getText("declarations/view/MainView.xml");

    public function new() {
        menuSelectedIndex = 0;
    }
}
