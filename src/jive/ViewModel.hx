package jive;

import bindx.IBindable;
import jive.themes.Theme;

@:bindable
class ViewModel implements IBindable {
    public var theme: Theme;
    public function new() {
        theme = new Theme();
    }
}
