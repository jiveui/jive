package jive;

import org.aswing.JPanel;

/**
* Shows only one of children
**/
class Spot extends JPanel {
    public function new() {
        super();
    }

    public var selectedIndex(get, set): Int;
    private var _selectedIndex: Int;
    private function get_selectedIndex(): Int { return _selectedIndex; }
    private function set_selectedIndex(v: Int) {
        _selectedIndex = v;
        for (i in 0...getComponentCount()) {
            getComponent(i).visibility = _selectedIndex == i;
        }
        doLayout();
        return v;
    }
}
