package jive.plaf.flat.tabbedpane;

import org.aswing.AbstractButton;
import org.aswing.plaf.basic.tabbedpane.BasicTabbedPaneTab;

class FlatTabbedPaneTab extends BasicTabbedPaneTab {
    public function new() { super(); }

    override private function createHeaderButton(): AbstractButton{
        var btn:AbstractButton = new FlatTabButton();
        btn.setBackgroundDecorator(new FlatTabBackground(this));
        btn.setTextFilters([]);
        return btn;
    }
}
