package demo.viewmodel;

import demo.viewmodel.AdjusterViewModel;
import bindx.IBindable;

class DemoViewModel implements IBindable {

    @:bindable public var buttonsVM: ButtonsViewModel = new ButtonsViewModel();
    @:bindable public var textVM: TextViewModel = new TextViewModel();
    @:bindable public var progressVM: ProgressViewModel = new ProgressViewModel();
    @:bindable public var comboboxVM: ComboBoxViewModel = new ComboBoxViewModel();
    @:bindable public var accordionVM: AccordionViewModel = new AccordionViewModel();
    @:bindable public var frameVM: FrameViewModel = new FrameViewModel();
    @:bindable public var adjusterVM: AdjusterViewModel = new AdjusterViewModel();
    @:bindable public var tableVM: TableViewModel = new TableViewModel();

    @:bindable public var menuSelectedIndex(default, set): Int;
    private function set_menuSelectedIndex(v: Int): Int {
        menuSelectedIndex = v;
        var vms:Array<Spotable> = [buttonsVM, textVM, progressVM, comboboxVM, accordionVM, frameVM, adjusterVM, tableVM];
        vms[menuSelectedIndex].selectedSpotIndex = 0;
        return v;
    }

    @:bindable public var areLinksVisible: Bool = false;

    public function new() {
        menuSelectedIndex = 0;
    }
}
