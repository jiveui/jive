package viewmodel;

import bindx.IBindable;

class ProgressViewModel implements IBindable {

    @bindable public var isScrollbarIndeterminate: Bool = false;
    @bindable public var sliderValue: Int = 0;

    public function new() {}
}
