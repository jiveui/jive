package jive;

import bindx.IBindable;
import jive.themes.Theme;

class ViewModel implements IBindable {
    @bindable public var theme: Theme;
    public function new() {}
}
