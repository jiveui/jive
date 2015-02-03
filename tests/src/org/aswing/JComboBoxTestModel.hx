package org.aswing;

import bindx.IBindable;

class JComboBoxTestModel implements IBindable {
    public function new() {}
    @bindable public var selected: Dynamic;
    @bindable public var index: Int;
}
